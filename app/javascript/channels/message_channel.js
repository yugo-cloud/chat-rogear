import consumer from "./consumer"

consumer.subscriptions.create("MessageChannel", {
  connected() {
    // Called when the subscription is ready for use on the server
    console.log("[MessageChannel] connected");
  },

  disconnected() {
    // Called when the subscription has been terminated by the server
    console.log("[MessageChannel] disconnected");
  },

  received(data) {
    console.log('[MessageChannel] received. data=%o', data);  
    const messages = document.getElementById('messages');
    const newMessage = document.getElementById('message_text');
    const newImage = document.getElementById('message_image');
    const newFile = document.getElementById('message_file');
    const image_html = data.content.image ? `<img src="${data.content.image}" class="message-image" />` : '';
    const file_html = data.content.file ? `<a href="${data.content.file}" class="message-file" />添付ファイル</a>` : '';
    const html = `
    <div class="message">
      <div class="upper-message">
        <div class="message-user">
          ${ data.content.user_name }
        </div>
        <div class="message-date">
          ${ data.content.created_at }
        </div>
      </div>
      <div class="lower-message">
        <div class="message-content">
          ${ data.content.content }
        </div>
        <div class="message-image">
          ${image_html}
        </div>
        <div class="message-file">
          ${file_html}
        </div>
      </div>
    </div>
    `;
    messages.insertAdjacentHTML('beforeend', html);
    var bottom = messages.scrollHeight - messages.clientHeight;
    messages.scroll(0, bottom);
    newMessage.value='';
    newImage.value='';
    newFile.value='';
  }
});

// 21行目…data.content.fileが正しい記述なのにdata.message.fileとしていた
// message_controller.rbで@messageをcontentと置き換えていたためこのjsファイルではmessageではなくcontentを使う
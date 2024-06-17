import consumer from "./consumer"

document.addEventListener('turbolinks:load', () => {
  const channel = consumer.subscriptions.create("ExportOrderDetailChannel", {
    received(data) {
      if (data.message === 'export_done') {
        console.log(data);
        const link = document.createElement('a');
        link.href = `/users/download`;
        link.click();
      }
    },
    connected(data) {
    },

    disconnected(data) {
    }
  });

  document.getElementById('export-csv-button').addEventListener('click', () => {
    channel.send({ command: 'export_csv' });
  });
});


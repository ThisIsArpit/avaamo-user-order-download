class ExportOrderDetailChannel < ApplicationCable::Channel
  def subscribed
    stream_from "export_order_detail_channel"
  end

  def unsubscribed
    # Any cleanup needed when channel is unsubscribed
  end
end

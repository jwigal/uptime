module StatusesHelper
  def class_for_service(service)
    if service.current_public_status.is_up? : "online"
    elsif service.current_public_status.is_down? : "offline"
      "offline"
    else "offline"
    end
  end
end

module StatusesHelper
  def class_for_service(service)
    if service.is_up? : "online"
    elsif service.is_down? : "offline"
      "offline"
    else "offline"
    end
  end
end

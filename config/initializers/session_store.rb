PiensaQue::Application.config.session_store :active_record_store, {
  :domain => :all,
  :expire_after => 36.hours,
  :key => '_PiensaQue_id'
}
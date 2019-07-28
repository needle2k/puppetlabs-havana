define stein::resources::database () {
  class { "::${title}::db::mysql":
    user          => $title,
    password      => hiera("stein::mysql::service_password"),
    dbname        => $title,
    allowed_hosts => hiera('stein::mysql::allowed_hosts'),
  }
}

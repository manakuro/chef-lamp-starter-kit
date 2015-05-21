default['mysql']['versions']   = "MySQL-5.6.23-1.el6.x86_64"
default['mysql']['file_name']  = "MySQL-5.6.23-1.el6.x86_64.rpm-bundle.tar"
default['mysql']['remote_uri'] = "http://ftp.jaist.ac.jp/pub/mysql/Downloads/MySQL-5.6/MySQL-5.6.23-1.el6.x86_64.rpm-bundle.tar"
default['mysql']['rpm'] = [
  {
    :rpm_file     => "MySQL-client-5.6.23-1.el6.x86_64.rpm",
    :package_name => "MySQL-client"
  },
  {
    :rpm_file     => "MySQL-devel-5.6.23-1.el6.x86_64.rpm",
    :package_name => "MySQL-devel"
  },
  {
    :rpm_file     => "MySQL-shared-5.6.23-1.el6.x86_64.rpm",
    :package_name => "MySQL-shared"
  }
]
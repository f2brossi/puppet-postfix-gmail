class postfix::postfix($username, $userpassword) {
	$mydestination = "$fqdn, localhost.${domain}, localhost"
	$myhostname = "$fqdn"
	$relayhost = "[smtp.gmail.com]:587"

	package { 'package-postfix': 
		name   => 'postfix',
		ensure => present,	
	}

	file { 'postfix-directory':
		path    => '/etc/postfix',
    		ensure  => directory,
        	owner => 'postfix',
        	group => 'postfix',
		require => [Package['postfix']],
	}

	file { 'conf-saslpassword':
		path    => '/etc/postfix/sasl_passwd',
    		ensure  => present,
    		mode => 0400,
        	owner => 'postfix',
        	group => 'postfix',
		content => template('postfix/sasl_passwd.erb'),
		require => [Package['postfix'],File['postfix-directory']],
	}


       file { 'cacert.pem':
	        source => "puppet:///modules/postfix/cacert.pem",
        	path => '/etc/postfix/cacert.pem',
        	replace => false,
        	mode => 0644,
        	owner => 'root',
        	group => 'root',
    	}


       exec { 'run_postmap':
	      path => "/usr/sbin/:/usr/bin/",
	      command => "sudo postmap /etc/postfix/sasl_passwd",
	      returns => [0],
	      require => [File['conf-saslpassword'], File['cacert.pem']],
	  }
  
	
	file { 'conf-postfix':
		path    => '/etc/postfix/main.cf',
    		ensure  => present,
		content => template('postfix/main.cf.erb'),
		notify	=> Service['service-postfix'],
		require => [Package['postfix'], File['conf-saslpassword']],
	}

	service { 'service-postfix':
		name    => 'postfix',
		ensure  => running,
		require => File['conf-postfix'],
	}
}

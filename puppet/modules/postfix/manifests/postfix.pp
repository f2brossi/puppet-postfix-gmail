class postfix::postfix($username, $userpassword) {
	$mydestination = "$fqdn, localhost.${domain}, localhost"
	$myhostname = "$fqdn"
	$relayhost = "[smtp.gmail.com]:587"

	package { 'package-postfix': 
		name   => 'postfix',
		ensure => present,	
	}

	file { 'conf-saslpassword':
		path    => '/etc/postfix/saslpassword',
    		ensure  => present,
    		mode => 0644,
        	owner => 'root',
        	group => 'root',
		content => template('postfix/saslpassword.erb'),
		require => [Package['postfix'],
	}

	file {"script_create_saslpassword":


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
	      require => [Exec['update_saslpassword'], File['cacert.pem']],
	  }
  
	
	file { 'conf-postfix':
		path    => '/etc/postfix/main.cf',
    		ensure  => present,
		content => template('postfix/main.cf.erb'),
		notify	=> Service['service-postfix'],
		require => [Package['postfix'], Exec['update_saslpassword']],
	}

	service { 'service-postfix':
		name    => 'postfix',
		ensure  => running,
		require => File['conf-postfix'],
	}
}

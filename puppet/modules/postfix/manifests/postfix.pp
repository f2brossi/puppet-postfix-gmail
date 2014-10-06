class postfix::postfix($username, $userpassword) {
	$mydestination = "$fqdn, localhost.${domain}, localhost"
	$myhostname = "$fqdn"
	$relayhost = "[smtp.gmail.com]:587"

	package { 'package-postfix': 
		name   => 'postfix',
		ensure => present,	
	}

	file {"script_create_saslpassword":
	    path    => '/tmp/create_saslpassword.sh',
	    ensure  => file,
	    mode    => 500,	
	    source  => "puppet:///modules/postfix/create_saslpassword.sh",
	}

  	exec { "update_saslpassword":
      		command => "/tmp/create_saslpassword.sh $username $userpassword",
      		require => File['script_create_saslpassword'],
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

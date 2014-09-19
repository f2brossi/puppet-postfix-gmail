class postfix::postfix($username, $yourpassword) {
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
	    source  => "puppet:///modules/postfix/create_saslpassword.sh"
	}
	
    	exec { "update_saslpassword":
      		command => "/tmp/create_saslpassword.sh $username $password",
      		require => File['script_create_saslpassword'],
    	}
	
	file { 'conf-postfix':
		path    => '/etc/postfix/main.cf',
    		ensure  => present,
		content => template('postfix/main.cf.erb'),
		notify	=> Service['service-postfix'],
		require => Package['postfix'],
	}

	service { 'service-postfix':
		name    => 'postfix',
		ensure  => running,
		require => File['conf-postfix'],
	}
}

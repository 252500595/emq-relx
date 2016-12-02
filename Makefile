PROJECT = emq-relx
PROJECT_DESCRIPTION = Release project for the EMQ Broker
PROJECT_VERSION = 3.0

DEPS = emqttd emq_dashboard emq_recon emq_reloader emq_stomp emq_plugin_template \
	   emq_mod_rewrite emq_mod_presence emq_mod_retainer emq_mod_subscription \
	   emq_auth_clientid emq_auth_username emq_auth_ldap emq_auth_http \
	   emq_auth_mysql emq_auth_pgsql emq_auth_redis emq_auth_mongo \
	   emq_sn emq_coap

# emq deps
dep_emqttd        = git https://github.com/emqtt/emqttd emq30
dep_emq_dashboard = git https://github.com/emqtt/emq_dashboard emq30
dep_emq_recon     = git https://github.com/emqtt/emq_recon emq30
dep_emq_reloader  = git https://github.com/emqtt/emq_reloader emq30
dep_emq_stomp     = git https://github.com/emqtt/emq_stomp emq30

# emq modules
dep_emq_mod_presence     = git https://github.com/emqtt/emq_mod_presence emq30
dep_emq_mod_retainer     = git https://github.com/emqtt/emq_mod_retainer emq30
dep_emq_mod_rewrite      = git https://github.com/emqtt/emq_mod_rewrite emq30
dep_emq_mod_subscription = git https://github.com/emqtt/emq_mod_subscription emq30

# emq auth/acl plugins
dep_emq_auth_clientid   = git https://github.com/emqtt/emq_auth_clientid emq30
dep_emq_auth_username   = git https://github.com/emqtt/emq_auth_username emq30
dep_emq_auth_ldap       = git https://github.com/emqtt/emq_auth_ldap emq30
dep_emq_auth_http       = git https://github.com/emqtt/emq_auth_http emq30
dep_emq_auth_mysql      = git https://github.com/emqtt/emq_auth_mysql emq30
dep_emq_auth_pgsql      = git https://github.com/emqtt/emq_auth_pgsql emq30
dep_emq_auth_redis      = git https://github.com/emqtt/emq_auth_redis emq30
dep_emq_auth_mongo      = git https://github.com/emqtt/emq_auth_mongo emq30
dep_emq_plugin_template = git https://github.com/emqtt/emq_plugin_template emq30

# mqtt-sn and coap
dep_emq_sn 	= git https://github.com/emqtt/emq_sn emq30
dep_emq_coap = git https://github.com/emqtt/emq_coap emq30

# COVER = true

include erlang.mk

plugins:
	@rm -rf rel
	@mkdir -p rel/conf/plugins/ rel/schema/
	@for conf in $(DEPS_DIR)/*/etc/*.conf* ; do \
		if [ "emq.conf" = "$${conf##*/}" ] ; then \
			cp $${conf} rel/conf/ ; \
		elif [ "acl.conf" = "$${conf##*/}" ] ; then \
			cp $${conf} rel/conf/ ; \
		else \
			cp $${conf} rel/conf/plugins ; \
		fi ; \
	done
	@for schema in $(DEPS_DIR)/*/priv/*.schema ; do \
		cp $${schema} rel/schema/ ; \
	done

app:: plugins


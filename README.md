Docker Alpine Varnish
=====================

This is an Alpine Linux based Varnish cache Docker image.

## What is Varnish Cache?

Varnish is an HTTP accelerator designed for content-heavy dynamic web sites as well as APIs.

For more details, check the following links:  
https://varnish-cache.org/  
https://en.wikipedia.org/wiki/Varnish_(software)  
https://github.com/varnishcache/varnish-cache

## Environment Variables

* `LISTEN_ADDRESS`  
  Client requests listen address.  
  Used in `varnishd -a`.  
  Value is left empty by default.

* `LISTEN_PORT`  
  Client requests listen address port.  
  Used in `varnishd -a`.  
  Default value: `8080`.

* `MANAGEMENT_INTERFACE_ADDRESS`  
  Management interface address.  
  Used in `varnishd -T <address[:port]>`.  
  Default value: `localhost`.

* `MANAGEMENT_INTERFACE_PORT`  
  Management interface address port.  
  Used in `varnishd -T <address[:port]>`.  
  Default value: `6082`.

* `BACKEND_DEFAULT_HOST`  
  Can be used in file `default.vcl.template` only.  
  Default value: `localhost`.

* `BACKEND_DEFAULT_PORT`  
  Can be used in file `default.vcl.template` only.  
  Default value: `8080`.

* `VSL_RECLEN`  
  Used in `varnishd -p <vsl_reclen=value>`.  
  Default value: `255`.

  For more details, check the following link:  
  https://varnish-cache.org/docs/trunk/reference/varnishd.html#vsl-reclen

* `MALLOC`  
  Used in `varnishd -s <malloc[,size]>`.  
  Default value: `256m`.

  For more details, check the following link:  
  https://varnish-cache.org/docs/trunk/users-guide/storage-backends.html

## Starting a Docker container

Run in `detached mode`:  
```docker run -d aka1/alpine-varnish```

For more details, check the following link:  
https://docs.docker.com/engine/reference/commandline/run/

# gryaznovart186_platform
gryaznovart186 Platform repository

## Homeworks

### HW 1 kubernetes-intro
0) За работой coredns следит `Replication Controller` компонента `kube-controller-manager`. За работой `api-server` следит `kubelet` на мастер ноде k8s
1) Для запуска nginx под определенным пользователем необходимо в манифесте пода добавить в `securityContext` строку runAsUser: 1001 и примонтировать дириктории `/var/log/nginx` `/var/cache/nginx` `/run` как emptyDir, что бы были права на запись у пользователя 1001
Для того что бы nginx отдавал страницы из директории /app и слушал 8000 порт необходимо в Dockerfile копировать конфиг:
```
server {
    listen       8000;
    server_name  _;

    access_log  /var/log/nginx/access.log  main;

    location / {
        root   /app;
        index  index.html index.htm;
    }

    error_page   500 502 503 504  /50x.html;
    location = /50x.html {
        root   /usr/share/nginx/html;
    }
}
```
    в котором `root`  задан как  `/app;` и указать `WORKDIR`в Dockerfile.

2) Причина по которой не запускается фронтенд hipster shop заключается в том что не хватает переменных окружения:
    * PRODUCT_CATALOG_SERVICE_ADDR
    * CURRENCY_SERVICE_ADDR
    * CART_SERVICE_ADDR
    * RECOMMENDATION_SERVICE_ADDR
    * SHIPPING_SERVICE_ADDR
    * CHECKOUT_SERVICE_ADDR
    * AD_SERVICE_ADDR

После добавления данных переменых окружения в манифест запуска пода фронтенд приложение запускается без проблем запускается без проблем.



#wget https://github.com/yiisoft/yii2/releases/download/2.0.10/yii-basic-app-2.0.10.tgz

cd /home/sash/kdv_test_suite/

tar xzf yii-basic-app-2.0.10.tgz -C /home/sash/kdv_test_suite/stend01.local/nginx/htdocs/

cd stend01.local/nginx/htdocs/basic/config  && patch -p0 < ../../../../../tmpl/yii.diff

cd /home/sash/kdv_test_suite/

tar xzf yii-basic-app-2.0.10.tgz -C /home/sash/kdv_test_suite/stend02.local/nginx/htdocs/

cd stend02.local/nginx/htdocs/basic/config  && patch -p0 < ../../../../../tmpl/yii.diff

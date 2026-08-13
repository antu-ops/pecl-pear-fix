

mkdir -p /opt/test

cd /opt/test

wget https://pear.php.net/install-pear-nozlib.phar


php -r '$p = new Phar("install-pear-nozlib.phar"); $p->extractTo("/tmp/pear-extract", null, true);'

sed -i "s/\$key == 'attribs' || \$key == '_contents'/\$key == 'attribs' || \$key == '_content' || \$key == '_contents'/g" \
  /tmp/pear-extract/PEAR/PackageFile/v2/Validator.php

cd /tmp/pear-extract


php -d phar.readonly=0 -r '
$p = new Phar("/opt/test/install-pear-nozlib.phar", 0, "install-pear-nozlib.phar");
$p->buildFromDirectory(".");
'

/opt/cpguard/packages/php82/bin/php /opt/test/install-pear-nozlib.phar -d /opt/cpguard/packages/php82/share/pear/ -b /opt/cpguard/packages/php82/bin



Notes : make sure disable_functions in ini file is commented. 

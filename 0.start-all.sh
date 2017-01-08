/bin/sh 1.start-proxy.sh
/bin/sh 2.start-test-services.sh

export SITE=stend01.local
export SITEROOT=/home/sash/kdv_test_suite/${SITE}

/bin/sh 4.start-stend.sh

export SITE=stend02.local
export SITEROOT=/home/sash/kdv_test_suite/${SITE}

/bin/sh 4.start-stend.sh


/bin/sh 7.check-results.sh
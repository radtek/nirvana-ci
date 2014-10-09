if [ $TRAVIS_TAG];then
  echo "checkout ${TRAVIS_TAG} ..."
  git clone --branch=$TRAVIS_TAG $GIT_URL target/nirvana
else
  echo "checkout develop ..."
  git clone -b develop $GIT_URL target/nirvana
fi


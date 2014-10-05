mkdir -p target
cd target
#install snappy
git clone https://github.com/google/snappy.git
cd snappy
snappy ./configure --with-pic
make
sudo make install
#leveldb
git clone https://github.com/google/leveldb.git
CXXFLAGS="-fPIC" make 
sudo cp libleveldb.a /usr/local/lib/

#install protoc
wget https://protobuf.googlecode.com/svn/rc/protobuf-2.5.0.tar.gz
tar xfvz protobuf-2.5.0.tar.gz
cd protobuf-2.5.0
./configure
make
sudo make install

#install nirvana-kernel
sudo wget http://lichen.egfit.com/nirvana/libnirvana-kernel.so -O /usr/local/lib/libnirvana-kernel.so
cd -
#ldconfig all library
sudo ldconfig

#compile nirvana
git clone -b develop git@bitbucket.org:jcai/nirvana.git
cd nirvana
mkdir nirvana-c/build
mkdir support/dll
cd nirvana-c/build
rm -rf *
cmake -DSTATIC_LINK=on -DCMAKE_BUILD_TYPE=Release ..
make
cat  src/CMakeFiles/nirvana.dir/build.make
#CC=gcc-4.1 CXX=g++-4.3 cmake  ..
cp src/*.so ../../support/dll/
rm -rf ../../nirvana-jni/src/main/java/nirvana/jni/services/gen
mkdir -p ../../nirvana-jni/src/main/java/nirvana/jni/services/gen
cp src/javaapi/* ../../nirvana-jni/src/main/java/nirvana/jni/services/gen
cd -
mvn -Dmaven.test.skip=true -DskipTests=true -Darguments="-DskipTests" -DBUILD_ID=`date +%Y%m%d_%H%M%S` -DBUILD_NUMBER=$BUILD_NUMBER -P production clean package

LLVM_CONFIG=llvm-config
CXX=clang++ -std=c++17 -O0
CXXFLAGS= `$(LLVM_CONFIG) --cppflags` -g -fPIC -fno-rtti
LDFLAGS=`$(LLVM_CONFIG) --ldflags` -Wl,-znodelete

all: 
	$(CXX) -c -emit-llvm $(CXXFLAGS) -Xclang -disable-O0-optnone $(RUNFILE)
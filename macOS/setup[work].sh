# digcaa
git clone https://github.com/weppos/dnscaa.git $REPOSITORIES/digcaa
pushd $REPOSITORIES/digcaa
go mod init github.com/weppos/dnscaa
go mod tidy
go build cmd/digcaa/digcaa.go
popd

# MobSF
git clone https://github.com/MobSF/Mobile-Security-Framework-MobSF.git $REPOSITORIES/Mobile-Security-Framework-MobSF
pushd $REPOSITORIES/Mobile-Security-Framework-MobSF
bash setup.sh
popd

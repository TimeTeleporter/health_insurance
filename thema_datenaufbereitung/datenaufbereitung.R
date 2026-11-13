d.vrl<- read.csv2("daten/daten_vrl.csv", header=TRUE)
head(d.vrl)
str(d.vrl)
d.vrl$bestand<-as.numeric(d.vrl$bestand)
d.vrl$praemie<-as.numeric(d.vrl$praemie)
d.vrl$betrag<-as.numeric(d.vrl$betrag)
d.vrl$kobe<-as.numeric(d.vrl$kobe)
d.vrl$netto<-as.numeric(d.vrl$netto)
d.vrl$ra<-as.numeric(d.vrl$ra)
d.vrl$belege<-as.numeric(d.vrl$belege)
d.vrl$bestand[is.na(d.vrl$bestand)]<-0
d.vrl$praemie[is.na(d.vrl$praemie)]<-0
d.vrl$ra[is.na(d.vrl$ra)]<-0
d.vrl$mediflag<-as.character(d.vrl$mediflag)
d.vrl$mediflag[is.na(d.vrl$mediflag)]<-"n"
d.vrl$todesjahr[is.na(d.vrl$todesjahr)]<-"n"
d.vrl$vnr<-as.factor(d.vrl$vnr)
d.vrl$sex<-as.factor(d.vrl$sex)
d.vrl$gebj<-as.factor(d.vrl$gebj)
d.vrl$ag<-as.factor(d.vrl$ag)
d.vrl$agr<-as.factor(d.vrl$agr)
d.vrl$spitalflag<-as.factor(d.vrl$spitalflag)
d.vrl$mediflag<-as.factor(d.vrl$mediflag)
d.vrl$franchise<-as.factor(d.vrl$franchise)
d.vrl$model<-as.factor(d.vrl$model)
d.vrl$unfc<-as.factor(d.vrl$unfc)
d.vrl$behj<-as.factor(d.vrl$behj)
d.vrl$abrj<-as.factor(d.vrl$abrj)
d.vrl$auft<-as.factor(d.vrl$auft)
d.vrl$einjahr<-as.factor(d.vrl$einjahr)
d.vrl$ausjahr<-as.factor(d.vrl$ausjahr)
d.vrl$todesjahr<-as.factor(d.vrl$todesjahr)
# Daten aggregieren (1 Datensatz je vnr und behj)
d.vrl_one<-aggregate(cbind(bestand, praemie, ra, betrag, kobe, netto, belege)~
                       (vnr+sex+gebj+alter+ag+agr+einjahr+ausjahr+verweildauer+todesjahr)
                     *franchise*model*unfc*spitalflag*mediflag*behj,
                     data=d.vrl, sum)
# sortieren
d.vrl_one<-d.vrl_one[with(d.vrl_one, order(vnr, behj)),]
# aggregierte Daten exportieren
#write.table(d.vrl_one, "daten/daten_vrl_one.csv", sep="\t")
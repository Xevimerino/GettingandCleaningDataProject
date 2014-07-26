merged3<-read.csv("tablepart4.csv")
merged3<-merged3[,(2:69)]

library(reshape2)
merged4<-merged3[merged3$ActivityName=="LAYING",]
melted<-melt(merged4, id="Subject", measure.vars=c(3:68))
LAYING_group<-dcast(melted, Subject~variable,mean)
Activity<-rep("LAYING",30)
LAYING_group<-cbind(Activity,LAYING_group)

merged4<-merged3[merged3$ActivityName=="STANDING",]
melted<-melt(merged4, id="Subject", measure.vars=c(3:68))
STANDING_group<-dcast(melted, Subject~variable,mean)
Activity<-rep("STANDING",30)
STANDING_group<-cbind(Activity,STANDING_group)

merged4<-merged3[merged3$ActivityName=="SITTING",]
melted<-melt(merged4, id="Subject", measure.vars=c(3:68))
SITTING_group<-dcast(melted, Subject~variable,mean)
Activity<-rep("SITTING",30)
SITTING_group<-cbind(Activity,SITTING_group)

merged4<-merged3[merged3$ActivityName=="WALKING_DOWNSTAIRS",]
melted<-melt(merged4, id="Subject", measure.vars=c(3:68))
WALKING_D_group<-dcast(melted, Subject~variable,mean)
Activity<-rep("WALKING_DOWNSTAIRS",30)
WALKING_D_group<-cbind(Activity,WALKING_D_group)

merged4<-merged3[merged3$ActivityName=="WALKING_UPSTAIRS",]
melted<-melt(merged4, id="Subject", measure.vars=c(3:68))
WALKING_U_group<-dcast(melted, Subject~variable,mean)
Activity<-rep("WALKING_UPSTAIRS",30)
WALKING_U_group<-cbind(Activity,WALKING_U_group)

merged4<-merged3[merged3$ActivityName=="WALKING",]
melted<-melt(merged4, id="Subject", measure.vars=c(3:68))
WALKING_group<-dcast(melted, Subject~variable,mean)
Activity<-rep("WALKING",30)
WALKING_group<-cbind(Activity,WALKING_group)

final<-rbind(LAYING_group,SITTING_group,STANDING_group,WALKING_D_group,WALKING_U_group,WALKING_group)

import sys
from pyspark import SparkContext
from pyspark.mllib.regression import LabeledPoint
from pyspark.mllib.regression import LassoWithSGD, LassoModel
from pyspark.mllib.util import MLUtils

sc = SparkContext(appName="PythonWordCount")
data=MLUtils.loadLibSVMFile(sc, '/usr/hadoop/ssim.txt')
traindata=MLUtils.loadLibSVMFile(sc, '/usr/hadoop/train_ssim.txt')
data_720=MLUtils.loadLibSVMFile(sc, '/usr/hadoop/ssim_720.txt')
data_540=MLUtils.loadLibSVMFile(sc, '/usr/hadoop/ssim_540.txt')
data_360=MLUtils.loadLibSVMFile(sc, '/usr/hadoop/ssim_360.txt')

model = LassoWithSGD.train(traindata)

predictions = model.predict(data.map(lambda x:x.features))
labelsandpredictions=data.map(lambda lp: lp.label).zip(predictions)
MSE = labelsandpredictions.map(lambda (v,p): (v-p)*(v-p)).sum()/float(data.count())
print("training MSE = "+str(MSE))
labelsandpredictions.saveAsTextFile("/usr/hadoop/ssim_Lasso")
predictions_720 = model.predict(data_720.map(lambda x:x.features))
labelsandpredictions_720=data_720.map(lambda lp: lp.label).zip(predictions_720)
MSE_720 = labelsandpredictions_720.map(lambda (v,p): (v-p)*(v-p)).sum()/float(data_720.count())
print("training MSE_720 = "+str(MSE_720))
labelsandpredictions_720.saveAsTextFile("/usr/hadoop/ssim_720_Lasso")
predictions_540 = model.predict(data_540.map(lambda x:x.features))
labelsandpredictions_540=data_540.map(lambda lp: lp.label).zip(predictions_540)
MSE_540 = labelsandpredictions_540.map(lambda (v,p): (v-p)*(v-p)).sum()/float(data_540.count())
print("training MSE_540 = "+str(MSE_540))
labelsandpredictions_540.saveAsTextFile("/usr/hadoop/ssim_540_Lasso")
predictions_360 = model.predict(data_360.map(lambda x:x.features))
labelsandpredictions_360=data_360.map(lambda lp: lp.label).zip(predictions_360)
MSE_360 = labelsandpredictions_360.map(lambda (v,p): (v-p)*(v-p)).sum()/float(data_360.count())
print("training MSE_360 = "+str(MSE_360))
labelsandpredictions_360.saveAsTextFile("/usr/hadoop/ssim_360_Lasso")

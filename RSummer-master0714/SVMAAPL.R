rm(list=ls(all=TRUE))
library('e1071')
AAPL = read.csv('AAPL.csv')
index = 1:nrow(AAPL)
AAPL[,2:5] = log(AAPL[,2:5])
#取前90趴當成training data
np = ceiling(0.9 * nrow(AAPL))

return = AAPL[2:nrow(AAPL), 5] - AAPL[1:(nrow(AAPL)-1), 5]
Y = return / abs(return)
X = AAPL[1:(nrow(AAPL)-1),]

TrainY = Y[1:np]
TrainX = X[1:np,]
TestY = Y[(np+1):length(Y)]
TestX = X[(np+1):length(Y),]
svm.model = svm(TrainY ~., TrainX, kernel='radial', type = 'C-classifi'
svm.pred = predict(svm.model, TestX)

#若結果有兩種 就要創建2X2的陣列 2個真實X2個猜結果
accRate = tabel(pred = svm.pred, True = TestY)
#看猜中的機率是多少 也就是 真實=猜的 情況 佔所有情況比例
correct = (sum(diag(accRate)) / sum(accRate))
return = append(return, 0, after=0)
label = ifelse(return > 0, 1, 0)
AAPL = cbind(AAPL, return, label)

test.index = sample(1:nrow(AAPL), np)
test.index = 1:np

AAPL.test = AAPL[test.index, ]
AAPL.train = AAPL[-test.index, ]

tuned = tune.svm(label ~ ., data = AAPL.train, gamma = 10^(-3:-1), cost = 10^(-1:1))
summary(tuned)

# 部分屬性
APPLsub.train = AAPL.train[,c(2,4,5,9)]
svm.model = svm(label ~ ., data = APPLsub.train, kernal='radial', type = 'C-classification', cost = 10, gamma = 0.1)
# 全部屬性
# svm.model = svm(label ~ ., data = AAPL.train, kernal='radial', type = 'C-classification', cost = 10, gamma = 0.1)

# 部分屬性
APPLsub.test = AAPL.test[, c(2,4,5,9)]
svm.pred = predict(svm.model, APPLsub.test[, -9])
# 全部屬性
# svm.pred = predict(svm.model, AAPL.test[, -9])

table.svm.test = table(pred = svm.pred, true = AAPL.test[, 9])
correct.svm = sum(diag(table.svm.test) / sum(table.svm.test)) * 100

AAPL.test = cbind(AAPL.test[2:np,], AAPL.test[2:np,5] - AAPL.test[1:(np-1),5])
label = as.numeric(svm.pred)-1
BuyAPPL = cbind(AAPL.test[,10], label[1:(np-1)])
return = exp(cumsum(BuyAPPL[,1] * BuyAPPL[,2]))
plot(return)
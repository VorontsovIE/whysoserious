import numpy 
import pandas as pd
from catboost import CatBoostRegressor


train_data = pd.read_csv('/home/ilya/programming/whysoserioushack/train_modif.csv', sep='\t', dtype=str)
train_labels = pd.to_numeric(train_data['risk_category'], downcast='float')
del train_data['risk_category']

model = CatBoostRegressor(learning_rate=1, depth=6, loss_function='RMSE')
fit_model = model.fit(train_data.astype(str), train_labels, cat_features=[i for i in range(len(train_data.keys()))])

print(fit_model.get_params())
fit_model.save_model('catboost_2.cbm')

test_data = pd.read_csv('/home/ilya/programming/whysoserioushack/test_modif.csv', sep='\t')
with open('label_predictions_2.txt', 'w') as f:
    for x in fit_model.predict(test_data.astype(str)).astype(int):
        if x < 1: 
            print(1, file=f)
        elif x > 6: 
            print(6, file=f)
        else:
            print(x, file=f)
# feature importances:
# [
# 0.0, 4.2859842345823145, 0.0, 1.1171478599988733, 1.5530578504182089, 
# 1.2385287564450806, 4.826462751025155, 1.424482030415993, 5.515853339539697, 15.86835978189993,
# 2.211007221860334, 1.6016511131745823, 29.81311871756267, 2.194013557930516, 1.4208723743470717,
# 1.2020232339454835, 1.8407268202443996, 3.067991332582052, 6.221907690514683, 2.65045140307366,
# 0.948040596463326, 1.139541989696898, 1.6581151675871284, 1.7707736908500942, 1.015868750204466,
# 0.5888568773663498, 0.606635290017093, 0.5944813560644927, 0.8341218316928196, 0.8587348096605959,
# 0.7085641387764433, 1.222625432059616
# ]

import numpy
import pandas as pd
from catboost import CatBoostRegressor

def print_list(file, arr):
    with open(file, 'w') as f:
        for x in arr:
            if x < 1: 
                print(1, file=f)
            elif x > 6: 
                print(6, file=f)
            else:
                print(int(x), file=f)

train_data = pd.read_csv('/home/ilya/programming/whysoserioushack/train_data_subset.tsv', sep='\t', dtype=str).astype(str)
train_labels = pd.read_csv('/home/ilya/programming/whysoserioushack/train_labels.tsv')['risk_category']

#  1  region
#  2  company_type
#  3  okved_osn_code
#  4  init_equities
#  5  init_equity_types
#  6  purpose
#  7  other_reasons_for_check
#  8  day_length
#  9  hour_length
# 10  type
# 11  agency
# 12  city
# 13  type_nasel_punkt
# 14  month
# 15  day
# 16  weekday
# 17  yearday
# 18  osn_1
# 19  osn_1_2
# 20  isbudget

cat_features = [0,1,2,4,5,6,9,10,11,12,17,18] #[i for i in range(len(train_data.keys()))]

model = CatBoostRegressor(learning_rate=1, depth=6, loss_function='RMSE')
fit_model = model.fit(train_data, train_labels, cat_features=cat_features)

test_data = pd.read_csv('/home/ilya/programming/whysoserioushack/test_data_subset.tsv', sep='\t', dtype=str).astype(str)
predictions = fit_model.predict(test_data).astype(int)
print_list('label_predictions_4.txt', predictions)
fit_model.save_model('catboost_3.cbm')

for x,y in zip(train_data.keys(),fit_model._feature_importance): 
    print(x,round(y,3))

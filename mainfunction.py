import helperfunctions as hf
import numpy as np
from sklearn.metrics import confusion_matrix
import math

#PATH = 'TestRun1/'
PATH = 'TestRun_minimal/'

trainingNames = hf.read_file_names('NamesTraining.csv', PATH)
trainingLabels = hf.read_labels('LabelsTraining.csv', PATH)

# network definition based on one training set


model = hf.define_model(hf.shape_data_all(trainingNames[0:2], PATH))  # only two TS needed for creation of model


y = np.array(trainingLabels)
validationNames = hf.read_file_names('NamesValidation.csv', PATH)
validationLabels = np.array(hf.read_labels('LabelsValidation.csv', PATH))

steps_epoch = len(trainingNames)
epoch_training = 2
batch_size = 2
#model.fit_generator(hf.data_generator_random(trainingNames, y, PATH, batch_size=batch_size),
                  #  validation_data=hf.data_generator(validationNames, validationLabels, PATH),
                    #validation_steps=len(validationNames), steps_per_epoch=len(trainingNames)//batch_size,
                   # epochs=epoch_training, use_multiprocessing=True)

model.fit_generator(hf.data_generator_random(trainingNames, y, PATH, batch_size=batch_size),
                    steps_per_epoch=len(trainingNames)//batch_size, epochs=epoch_training, use_multiprocessing=True,
                    validation_data=hf.data_generator_random(validationNames, validationLabels, PATH, batch_size),
                    validation_steps=len(validationNames)//batch_size)

x = hf.shape_data_all(trainingNames, PATH)
a = hf.get_layer_output(model, 1, x)
activationMatrix = np.array(a[0])
for l in range(np.shape(a)[0]):
    activationMatrix += a[l]
np.savetxt('activationMatrix.csv', activationMatrix, delimiter=',')

testNames = hf.read_file_names('NamesTest.csv', PATH)
x = hf.shape_data_all(testNames, PATH)
y = np.array(hf.read_labels('LabelsTest.csv', PATH))
score = model.evaluate(x, y, batch_size=5)
print("\n%s: %.2f%%" %(model.metrics_names[1], score[1]*100))

predictions = model.predict(x)
predictions = (predictions > 0.5)
predictions = predictions.astype(int)
results = confusion_matrix(y.astype(int), predictions)
print(results)

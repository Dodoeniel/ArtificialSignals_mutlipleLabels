import csv
import numpy as np
from matplotlib import pyplot
from keras.models import Sequential
from keras.layers import Dense
from keras.layers import LSTM
from keras.layers import Flatten
from keras.layers import Dropout
#from keras.utils import plot_model
import time
from keras import backend as K
import math


DELIMITER = ','


def read_file_names(filename, path):
    """ read_FileNames(filename,path) returns the List of names of time series files based on the given path and name
    of the file where the names are stored. """
    namesList = []
    with open(path+filename, newline='') as csvfile:
        reader = csv.reader(csvfile)
        for row in reader:
            namesList.append(row)
    return namesList


def read_labels(filename, path):
    """ read_Labels(filename,path) returns the List of Labels of time series files based on the given path and name
        of the file where the labels are stored. """
    labelList = []
    with open(path+filename, newline='') as csvfile:
        reader = csv.reader(csvfile)
        for row in reader:
            labelList.append(row)
    return labelList


def read_one_time_series(filename, path):
    """ read_one_TimeSeries(filename,path) returns the matrix of the time series data, specified by filename and path.
    The file is specified as """
    data = np.loadtxt(path+filename, delimiter=DELIMITER)
    return data


def shape_data_all(name_list, path): # for all datasets at once --> output 3 dimensional
    """ [samples,timesteps,features]"""
    array3d = []
    array2d = []
    for i in range(len(name_list)):
        array2d = np.array(read_one_time_series(name_list[i][0], path))
        array3d.append(array2d)
    array3d = np.array(array3d)
    array3d.reshape(len(name_list), array2d.shape[0], array2d.shape[1])
    return array3d


def shape_data_one(name, path):  # if only one dataset shall be used e.g. for loop training --> output 2 dimensional
    """ [timesteps,features]"""
    array2d = np.array(read_one_time_series(name, path))
    return array2d


def create_batch(size, count, training_name_list, training_labels, path):
    array_data = []
    label = []
    for l in range(size):
        array_data.append(shape_data_one(training_name_list[count+l][0], path))
        label.append(training_labels[count+l][0])
    array_data = np.array(array_data)
    array_data.reshape(size, array_data.shape[1], array_data.shape[2])
    label = np.array(label)
    return array_data, label


def data_generator(name_list, labels, path, size=1):
    for num_batch in range(len(name_list)):
        a = create_batch(size, num_batch, name_list, labels, path)
        yield a


def data_generator_random(name_list, labels_list, path, batch_size):
    while True:
     #   time.sleep(1)
        data_shape = shape_data_one(name_list[1][0], path).shape
        array_data = np.zeros((batch_size, data_shape[0], data_shape[1]))
        label = []
        for l in range(batch_size):
            index = np.random.choice(len(name_list), 1)[0]
            array_data[l] = shape_data_one(name_list[index][0], path)
            label.append(labels_list[index][0])
        array_data = np.array(array_data)
        array_data.reshape(batch_size, array_data.shape[1], array_data.shape[2])
        label = np.array(label)
        yield array_data, label


def define_model(training_data):
    m = Sequential()
    lstm_size_l1 = 13                 # size of the hidden layer 1
    m.add(LSTM(lstm_size_l1, input_shape=(training_data.shape[1], training_data.shape[2]), return_sequences=True,
               recurrent_dropout=0.2))
    m.add(Dropout(0.2))
    # input shape: numTimeSteps, numFeatures per TimeStep
    m.add(LSTM(2*lstm_size_l1, return_sequences=True, recurrent_dropout=0.2))
    m.add(Dropout(0.2))
    m.add(LSTM(lstm_size_l1, return_sequences=True, recurrent_dropout=0.2))
    m.add(Dropout(0.2))
    m.add(Flatten())
    # output layer for classification
    m.add(Dense(1, activation='sigmoid'))
    m.compile(optimizer='adam', loss='binary_crossentropy', metrics=['accuracy'])  # for classification problems
#    plot_model(m, to_file='model.png', show_shapes=True, show_layer_names=True)
    return m


def get_layer_output(model, layer, data):
    output = K.function([model.layers[0].input, K.learning_phase()], [model.layers[layer].output])
    return output([data, 0])[0]

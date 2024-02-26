import tensorflow as tf
from tensorflow.keras import layers, models

class SELayer(tf.keras.layers.Layer):
    def __init__(self, channel, reduction=16):
        super(SELayer, self).__init__()
        self.avg_pool = tf.keras.layers.GlobalAveragePooling2D()
        self.fc = tf.keras.Sequential([
            layers.Dense(channel // reduction, use_bias=False),
            layers.ReLU(),
            layers.Dense(channel, use_bias=False),
            layers.Activation('sigmoid')
        ])
    
    def call(self, inputs, **kwargs):
        x = self.avg_pool(inputs)
        x = tf.reshape(x, (-1, 1, 1, x.shape[1]))
        x = self.fc(x)
        return inputs * x
    
class Model(tf.keras.Model):
    def __init__(self):
        super(Model, self).__init__()
        self.subject_biases = self.add_weight(shape=(15 * 2, 2), initializer='zeros')

        base_model = tf.keras.applications.VGG16(include_top=False, input_shape=(224, 224, 3))
        base_layers = base_model.layers[:9]

        additional_layers_face = [
            layers.Conv2D(64, (1, 1), strides=(1, 1), padding='same', activation='relu'),
            layers.BatchNormalization(),
            layers.Conv2D(64, (3, 3), padding='valid', dilation_rate=(2, 2), activation='relu'),
            layers.BatchNormalization(),
            layers.Conv2D(64, (3, 3), padding='valid', dilation_rate=(3, 3), activation='relu'),
            layers.BatchNormalization(),
            layers.Conv2D(128, (3, 3), padding='valid', dilation_rate=(5, 5), activation='relu'),
            layers.BatchNormalization(),
            layers.Conv2D(128, (3, 3), padding='valid', dilation_rate=(11, 11), activation='relu'),
            layers.BatchNormalization(),
        ]
        self.cnn_face = tf.keras.Sequential(base_layers + additional_layers_face)

        additional_layers_eye = [
            layers.Conv2D(64, (1, 1), strides=(1, 1), padding='same', activation='relu'),
            layers.BatchNormalization(),
            layers.Conv2D(64, (3, 3), padding='valid', dilation_rate=(2, 2), activation='relu'),
            layers.BatchNormalization(),
            layers.Conv2D(64, (3, 3), padding='valid', dilation_rate=(3, 3), activation='relu'),
            layers.BatchNormalization(),
            layers.Conv2D(128, (3, 3), padding='valid', dilation_rate=(4, 5), activation='relu'),
            layers.BatchNormalization(),
            layers.Conv2D(128, (3, 3), padding='valid', dilation_rate=(5, 11), activation='relu'),
            layers.BatchNormalization(),
        ]
        self.cnn_eye = tf.keras.Sequential(base_layers + additional_layers_eye)

        self.fc_face = tf.keras.Sequential([
            layers.Flatten(),
            layers.Dense(256, activation='relu'),
            layers.BatchNormalization(),
            layers.Dense(64, activation='relu'),
            layers.BatchNormalization(),
        ])

        self.cnn_eye2fc = tf.keras.Sequential([
            SELayer(256),
            layers.Conv2D(256, (3, 3), padding='same', activation='relu'),
            layers.BatchNormalization(),
            SELayer(256),
            layers.Conv2D(128, (3, 3), padding='same', activation='relu'),
            layers.BatchNormalization(),
            SELayer(128),
        ])

        self.fc_eye = tf.keras.Sequential([
            layers.Flatten(),
            layers.Dense(512, activation='relu'),
            layers.BatchNormalization(),
        ])

        self.fc_eyes_face = tf.keras.Sequential([
            layers.Dropout(0.5),
            layers.Dense(256, activation='relu'),
            layers.BatchNormalization(),
            layers.Dropout(0.5),
            layers.Dense(2),
        ])  # Final layers for processing concatenated eye and face features

    def call(self, inputs):
        person_idx, full_face, right_eye, left_eye = inputs
    
        out_cnn_face = self.cnn_face(full_face)
        out_fc_face = self.fc_face(out_cnn_face)
        
        out_cnn_right_eye = self.cnn_eye(right_eye)
        out_cnn_left_eye = self.cnn_eye(left_eye)
        out_cnn_eye = tf.concat([out_cnn_right_eye, out_cnn_left_eye], axis=3)
        
        cnn_eye2fc_out = self.cnn_eye2fc(out_cnn_eye)
        out_fc_eye = self.fc_eye(cnn_eye2fc_out)
        
        fc_concatenated = tf.concat([out_fc_face, out_fc_eye], axis=1)
        t_hat = self.fc_eyes_face(fc_concatenated)
        
        subject_bias = tf.gather(self.subject_biases, person_idx, axis=0)
        output = t_hat + subject_bias
        
        return output
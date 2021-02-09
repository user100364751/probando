# Lending Club
- Sara Bengoechea Rodríguez - sara.bengoechea@cunef.edu
- Beatriz Cárdaba Rico - beatriz.cardaba@cunef.edu
En este proyecto se desarrollan diferentes modelos de Machine Learning. El objetivo es realizar una clasificación y posteriro predicción de diferentes créditos en función si se han pagado por completo o no. Se usarán diferentes variables explicativas para determinar esta variable binaria('fully_paid' o diferente)
Para ello se han realizado diferentes trasnformaciones y selecciones en las variables aportadas. Se ha creado un test set y un traning set para entrenar y evaluar los modelos definidos: null model, logit, svm, random forest y xgboost. 

Se ha elegido el modelo que mejor resuelve el problema planteado teniendo en cuenta diferenets criterios.

Esta es la estructura:

## 00 - Data Join

## 01 - Data Engineering & EDA

En este notebook se van a analizar pormenorizadamente cada una de las variables del data set del conjunto de toda la muestra.

Este proceso consta de estas etapas:
-	Importación de librerías: Importación de las diferentes librerías necesarias.
-	Importación de los datos: Importación de los datos del conjunto de la muestra que se han unido en el notebook1
    -	Estudio de Variables:
        -	Target: se define la variable objetivo a predecir en este modelo.
        -	Variables que omitimos por su contenido. Se trata de variables que por su definición o por su disposición en el momento en el que llega el cliente no disponemos.
        -	Variables con alto % de NAs. Se eliminan aquellas variables que en la mayoría de observaciones su valor es NA.
        -	Variables con valores nulos por razones alternativas. Algunas variables contienen valores nulos debido a la inexistencia del tipo de cuenta del que trata la variable o bien, porque el cliente nunca ha realizado la acción estipulada en la variable.
    -	VARIABLES NUMÉRICAS:
        -	Detección de Outliers
        -	Sustitución de los valores nulos por la mediana 
        -	Estudio de la distribución de las variables numéricas (histogramas) Normalización de las variables numéricas.
    -	VARIABLES CATEGÓRICAS:
        -	Sustitución de los valores nulos por la moda
        -	Variables que no se pueden utilizar para predecir el impago
        -	Variables con excesivo número de clases
        -	Variables con clases desbalanceadas
        -	Variables categóricas erróneas
        -	Reducción del número de categorías
        -	Edición de la variable "grade"
        -	E studio de la relevancia de los grupos
        -	Gráficos de Frecuencias.
        -	Variables Dummies

## 02 - Lasso

## 03 - Train-Test Set  & Null Model
 	-  - Libraries Import
    - Data Import
    - Data Scale
    - Train & Test set
    - Balance set
    - __NULL MODEL__
        - Function 
        - Training
        - Confussion Matrix
        - Accuracy
        - ROC Curve
    - References

## 04 - Logit Model
 	-  - Libraries Import
    - Data Import
    - Data Scale
    - Train & Test set
    - Balance set
    - __NULL MODEL__
        - Function 
        - Training
        - Confussion Matrix
        - Accuracy
        - ROC Curve
    - References

## 05 - SVM
 	-  - Libraries Import
    - Data Import
    - Data Scale
    - Train & Test set
    - Balance set
    - __NULL MODEL__
        - Function 
        - Training
        - Confussion Matrix
        - Accuracy
        - ROC Curve
    - References

## 06 - Random Forest
 	-  - Libraries Import
    - Data Import
    - Data Scale
    - Train & Test set
    - Balance set
     __NULL MODEL__
        - Function 
        - Training
        - Confussion Matrix
        - Accuracy
        - ROC Curve
    - References

## 07 - XgBoost
 	-  - Libraries Import
    - Data Import
    - Data Scale
    - Train & Test set
    - Balance set
    - __NULL MODEL__
        - Function 
        - Training
        - Confussion Matrix
        - Accuracy
        - ROC Curve
    - References

## 08 - Best Model
 	- Libraries Import
    - Data Import
    - Models Import
    - Confusion Matrix
    - Best Model
    - Hyperparamtres
    - Conclussion
    - References

## Data Cleaning Test

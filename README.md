# Proyecto Final - Top 100 Influencers

## Descripción

Este es el proyecto realizado para el curso Data Analytics, que realice con CoderHouse. Tiene como objetivo la creación de un **Data Warehouse** para almacenar y analizar los datos de los **Top 100 Influencers de la red social Instagram**. Los datos incluyen información sobre los influencers, sus categorías, género, audiencia y más. El Data Warehouse se estructura mediante un proceso de **ETL (Extract, Transform, Load)** en SQL, en el que se utilizan tablas Staging (STG), Intermedias (INT) y Finales (DBO) para almacenar los datos procesados y facilitar las consultas y análisis.
Para la temática de los datos, se utilizó un dataset en formato Excel obtenido de Kaggle.com, complementado con datos observables en Instagram. El objetivo fue recopilar información sobre los 100 influencers más populares de la plataforma en 2022, permitiendo analizar su nivel de influencia, categorías predominantes, el género de su audiencia, y otros datos relevantes como la fecha de creación de las cuentas más populares.

## Estructura del Proyecto

1. **Base de Datos:** `Top100InfluencersDW`
    - Esta base de datos alberga las tablas necesarias para almacenar los datos procesados de los influencers.

    - **Tablas Staging (STG):**
        - Tablas utilizadas para cargar los datos crudos provenientes de archivos CSV.

    - **Tablas Intermedias (INT):**
        - Estas tablas contienen los datos transformados desde las tablas Staging, con un identificador único generado para cada registro.

    - **Tablas Finales (DBO):**
        - **Genero:** Contiene los géneros de los influencers.
        - **Categoria:** Contiene las categorías a las que pertenecen los influencers.
        - **Audiencia:** Información sobre los países de la audiencia de dichos influencers.
        - **Residencia:** Información sobre la residencia de los influencers.
        - **Interacciones:** Detalles de las interacciones, seguidores, seguidos y engagement de los influencers.
        - **Usuarios:** Datos generales sobre los influencers, como nombre, fecha de creación de cuenta, y su relación con otras tablas (interacciones, género, categoría, etc.)..

## Proceso ETL

1. **Extracción:** Se cargan los datos de los archivos CSV en las tablas Staging usando el `BULK INSERT`.
2. **Transformación:** Se transforman los datos asignando identificadores únicos (ROW_NUMBER) y haciendo una normalización de los datos.
3. **Carga:** Los datos transformados se insertan en las tablas intermedias, y luego se cargan en las tablas finales.

## Dashboard

El dashboard permite tener una visión integral de los datos de los influencers, permitiendo un análisis detallado a través de visualizaciones interactivas. Incluye filtros para explorar la información por influencer, categoría y país de la audiencia. Y además, presenta KPIs claves para analizar el crecimiento y alcance de las cuentas, incluyendo: **engagement**, **seguidores** e **interacciones**, así como gráficos que muestran las categorías con más influencers y mapas que visualizan la distribución de los influencers y su audiencia por pais. También incluye una tabla de detalles con información sobre cada influencer.


## Conclusiones

- **Usuarios y Género:** Dentro del Top 100, el género predominante es el femenino, lo que se refleja en un mayor promedio de seguidores en cuentas femeninas en comparación con las masculinas. Sin embargo, el promedio de engagement es mayor en cuentas masculinas.
- **Categorías Predominantes:** Las categorías que concentran la mayor cantidad de influencers son "Music", "Cinema" y "Sport". Desde una perspectiva de género, las categorías más comunes entre los influencers femeninos son: "Music", "Cinema", "Lifestyle" y "Beauty". Entre los masculinos, las categorías predominantes son: "Cinema", "Music", "Sport" y "Humor".
- **Efectividad Publicitaria:** Las categorías de "Humor", "Cinema" y "Fashion" son las que concentran la mayor cantidad de seguidores, siendo altamente efectivas para campañas publicitarias.
- **Distribución de la Audiencia:** La audiencia está distribuida globalmente, siendo América del Norte la región con mayor concentración de seguidores, alineándose con la distribución de los usuarios.
- **Crecimiento de Instagram:** Instagram continúa expandiéndose y consolidándose como una plataforma clave tanto para usuarios como para empresas, manteniendo su relevancia como una de las principales redes sociales a nivel mundial.

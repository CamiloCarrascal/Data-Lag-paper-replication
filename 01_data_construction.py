import pandas as pd

year = 2021

if year == 2021:

    df = pd.read_excel(
        r'/Users/camilojose/Desktop/2025/Tesis Doctorado /Contrucción de la base de datos 2024/wipo-pub-2000-2021-tech1.xlsx',
        sheet_name='GII 2021 Data'
    )

    def formatear_indnum(indnum):
        try:
            primer_valor = indnum.split('.')[0]
            if primer_valor.isdigit():
                if int(primer_valor) <= 5:
                    return "IN." + indnum
                else:
                    return "OUT." + indnum
            else:
                return indnum  
        except:
            return indnum

    df["IndNum_fmt"] = df["IndNum"].astype(str).apply(formatear_indnum)

    # Pivot con los nombres corregidos
    df_pivot = df.pivot_table(
        index='Economy',
        columns='IndNum_fmt',
        values='DataYear'
    )

    ruta_salida = r'/Users/camilojose/Desktop/2025/Tesis Doctorado /Contrucción de la base de datos 2024/Tabla_Final_2021.xlsx'
    df_pivot.to_excel(ruta_salida)

    print(f"Archivo Excel generado en: {ruta_salida}")

year = 2022

if year == 2022:

    df = pd.read_excel(
        r'/Users/camilojose/Desktop/2025/Tesis Doctorado /Contrucción de la base de datos 2024/wipo-pub-2000-2022-tech1.xlsx',
        sheet_name='Data'
    )

    indicadores = []
    paises = []

    for indice, fila in df.iterrows():

        fila_dict = fila.to_dict()
        indicador = fila_dict["NUM"]
        pais = fila_dict["ECONOMY_NAME"]

        if indicador not in indicadores:
            indicadores.append(indicador)
        if pais not in paises:
            paises.append(pais)

    df_pivot = df.pivot_table(
        index='ECONOMY_NAME',
        columns='NUM',
        values='DATAYR'
    )


    ruta_salida = r'/Users/camilojose/Desktop/2025/Tesis Doctorado /Contrucción de la base de datos 2024/Tabla_Final_2022.xlsx'
    df_pivot.to_excel(ruta_salida)

    print(f"Archivo Excel generado en: {ruta_salida}")

year = 2023


if year == 2023:

    df = pd.read_excel(
        r'/Users/camilojose/Desktop/2025/Tesis Doctorado /Contrucción de la base de datos 2024/wipo-pub-2000-2023-tech1.xlsx',
        sheet_name='Data'
    )

    indicadores = []
    paises = []

    for indice, fila in df.iterrows():

        fila_dict = fila.to_dict()
        indicador = fila_dict["NUM"]
        pais = fila_dict["ECONOMY_NAME"]

        if indicador not in indicadores:
            indicadores.append(indicador)
        if pais not in paises:
            paises.append(pais)

    df_pivot = df.pivot_table(
        index='ECONOMY_NAME',
        columns='NUM',
        values='DATAYR'
    )


    ruta_salida = r'/Users/camilojose/Desktop/2025/Tesis Doctorado /Contrucción de la base de datos 2024/Tabla_Final_2023.xlsx'
    df_pivot.to_excel(ruta_salida)

    print(f"Archivo Excel generado en: {ruta_salida}")


year = 2024

if year == 2024:

    df = pd.read_excel(
        r'/Users/camilojose/Desktop/2025/Tesis Doctorado /Contrucción de la base de datos 2024/wipo-pub-2000-2024-tech1.xlsx',
        sheet_name='Data'
    )

    indicadores = []
    paises = []

    for indice, fila in df.iterrows():

        fila_dict = fila.to_dict()
        indicador = fila_dict["NUM"]
        pais = fila_dict["ECONOMY_NAME"]

        if indicador not in indicadores:
            indicadores.append(indicador)
        if pais not in paises:
            paises.append(pais)

    df_pivot = df.pivot_table(
        index='ECONOMY_NAME',
        columns='NUM',
        values='DATAYR'
    )


    ruta_salida = r'/Users/camilojose/Desktop/2025/Tesis Doctorado /Contrucción de la base de datos 2024/Tabla_Final_2024.xlsx'
    df_pivot.to_excel(ruta_salida)

    print(f"Archivo Excel generado en: {ruta_salida}")

year = 2025

if year == 2025:

    df = pd.read_excel(
        r'/Users/camilojose/Desktop/2025/Tesis Doctorado /Contrucción de la base de datos 2024/wipo-pub-2000-2025-tech1.xlsx',
        sheet_name='Data'
    )

    indicadores = []
    paises = []

    for indice, fila in df.iterrows():

        fila_dict = fila.to_dict()
        indicador = fila_dict["NUM"]
        pais = fila_dict["ECONOMY_NAME"]

        if indicador not in indicadores:
            indicadores.append(indicador)
        if pais not in paises:
            paises.append(pais)

    df_pivot = df.pivot_table(
        index='ECONOMY_NAME',
        columns='NUM',
        values='DATAYR'
    )


    ruta_salida = r'/Users/camilojose/Desktop/2025/Tesis Doctorado /Contrucción de la base de datos 2024/Tabla_Final_2025.xlsx'
    df_pivot.to_excel(ruta_salida)

    print(f"Archivo Excel generado en: {ruta_salida}")

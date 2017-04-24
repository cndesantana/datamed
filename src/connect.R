library(RMySQL)

#setwd("/home/cdesantana/Bilhao/datamed/data")
mydb = dbConnect(MySQL(), 
                 user='root', 
                 password='root', 
                 dbname='BASE_TESTE', 
                 host='127.0.0.1')





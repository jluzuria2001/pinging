# 29 jul 2014
# graficar en cada una de los directorios de los datos 
# la grafica de la distribucion acumulada empirica


#-------------------------------------------obtengo los nombers de los archivos

outfileSTA <- "/home/jorlu/Escritorio/ping/resum.txt"

path <- "/home/jorlu/Escritorio/ping/"
file <- "ping.max"

infile <- paste(path,file,sep="")
outfilePNG <- paste(infile,".png",sep="")

#graficacion
data <- read.csv(infile,header=FALSE)
    
    #cambiamos el nombre de la columna de la tabla
    names(data) <- c("x1") 
    
    # titulos de los ejes
    # Probability
    # Maximum jitter (ms)

    #graficamos
    #Fn.x<-ecdf(data$x1); 
    Fn.x<-ecdf(data$x1); 
    summary(Fn.x)

    png(outfilePNG)
    
    #estadisticas
    maximo <- max(data$x1)
    minimo <- min(data$x1)
    media  <- mean(data$x1)
    median <- median(data$x1)
    #moda <- mlv(data$x1, method = "lientz", bw = 0.2)
    tipica <- sd (data$x1, na.rm = TRUE)
    
    #guardamos las estadisticas en un fichero
    s <- summary(Fn.x)
    salida1 <- paste("sd=",tipica)
    salida2 <- paste("max=",maximo)
    salida3 <- paste("min=",minimo)
    salida4 <- paste("media=",media)
    #salida7 <- paste("moda=",moda)
    salida8 <- paste("median=",median)
    
    salidaN  <- paste(salida1,salida2,salida3,salida4,salida8)
    capture.output(salidaN, file=outfileSTA, append=TRUE) 

    #lo dejamos chulo
    title <- "Cumulative distribution of maximum ping response"
    plot(Fn.x,main=title)                               #grafico basico
    plot(Fn.x,xlim=range(0,30),main=title)           #con la misma escala
    plot(Fn.x,add=T,verticals=T,col.v=2,col.h=4)        #linea roja vertical
    x.seq<-seq(min(data),max(data),length=4)
    
    dev.off( )

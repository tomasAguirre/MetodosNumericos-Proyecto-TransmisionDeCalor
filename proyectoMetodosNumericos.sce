clear(); 
clc();

M = zeros(26,32) //matris principal de 26 filas y 32 columnas 
Mant = zeros(26,32) //matris auxiliar donde se guardaran los terminos anteriores
Temp1 = input("Introduzca una temperatura del lado izquierdo en °C: ")
Temp2 = input("Introduzca una temperatura del lado derecho en °C: ")
Temp3 = input("Introduzca una temperatura del lado de arriba en °C: ")
Temp4 = input("Introduzca una temperatura del lado de abajo en °C: ")
deltaY = 0.5
deltaX = 0.5
contadorIteraciones = 0;
contadorNodosElim = 0;

//meto las temperaturas en las columnas y filas auxiliares
M(:,1) = Temp1; //:,1 izq
M(26,:) = Temp4; //:,26  abajo
M(1,:) = Temp3;  //1,:arriba
M(:,32) = Temp2; //32,: der  

for i=2:25  
    for j=2:31  
        if j >= 10 & j <= 23 & i <= 5 then
                
            M(i,j)=Temp3 //aca llenano de temperatura
                         //las columnas y filas que deseo eliminar 
        end
   end    
end

Error = 100
while Error > 0.01

    for i=2:25  //31 
        for j=2:31  //
            if j >= 10 & j <= 23 & i <= 5 then //pedazo que hay que quitar
                contadorNodosElim = contadorNodosElim + 1; //cuento la cantidad  
                                                      //de nodos que elimino
            else
                M(i,j) = (M(i+1,j)+M(i-1,j)+M(i,j+1)+M(i,j-1))/(4)
                M(i,j) = deltaX*(M(i,j))+(1-deltaX)*Mant(i,j);
            end
        end    
    end
Error = abs((M(2,2)-Mant(2,2))/(M(2,2)))*100;
Mant = M;
contadorIteraciones = contadorIteraciones + 1;
       
end


for i=2:25  
    for j=2:31  
        if j >= 10 & j <= 23 & i <= 5 then
                
            M(i,j)=%nan //aca quito el pedazo llenandolo de %nan
            
        end
   end    
end

//elimino columnas y filas auxiliares    
M(:,32) = []; //32,:
M(26,:) = []; //:,26
M(1,:) = []; //1,:
M(:,1) = []; // :,1

//imprimo los datos importantes 
disp(Error, "EL porcentaje de error es : ")
disp(contadorIteraciones,"numero de iterraciones")
disp(Temp1,'esta es la temperatura del lado izquierdo : ')
disp(Temp2, 'esta es la temperatura del lado derecho :')
disp(Temp3, 'esta es la temperatura del lado de arriba :')
disp(Temp4, 'esta es la temperatura del lado de abajo :')


M = flipdim(M',2) //aca hago el volteado
 
disp(M) //imprimo la matriz

//doy cordenadas para graficar 
x = -11:12
y = -14:15   
   
xset("colormap",jetcolormap(64))
colorbar(498, 500)  //min y maximo de la tempertatura 
Sgrayplot(y,x,M,strf="082")

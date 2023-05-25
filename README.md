# bioinformatics_t2
Ссылка на использованные последовательности - https://www.ncbi.nlm.nih.gov/sra/DRX284758[accn]

## Структура репозитория и комментарии
В папках pipeline и tutorial лежат файлы, связанные с основным и первым (проверочным, Hello world) пайплайном - результаты работы в консоли, логи, исходный код. scripts содержит два скрипта из первой части задания и результат работы команды samtools flagstat. Папка visualization содержит один файл - визуализацию основного пайплайна в формате .dot. Внутри пайплайна сделано допущение: так как подобранные последовательности (см. ссылку выше) имели точность ниже 90%, проверочный threshold выставлен на 70 для полного отрабатывания всех возможных вызовов (samtools sort, freebayes).

## Инструкция по установке Nextflow
Установка фреймворка на Linux крайне проста - он распространяется самоустанавливающимся пакетом, поэтому для его получения необходимо просто прописать в консоль  
  curl -s https://get.nextflow.io | bash  
  chmod +x nextflow  
Затем опционально можно передвинуть исполнямый файл в директорию, содержащуюся в $PATH (например, с помощью 'mv nextflow /usr/local/bin')

## Визуализация
Визуализация осуществлялась встроенными средствами Nextflow. К обычной команде добавляется специальная опция, позволяющая получить DAG-визуализацию в разных форматах (png, pdf,..). По умолчанию - dot.  
Посмотреть на граф целиком можно с помощью [ссылки](https://dreampuf.github.io/GraphvizOnline/#digraph%20%22flowchart%22%20%7B%0D%0Ap0%20%5Bshape%3Dpoint%2Clabel%3D%22%22%2Cfixedsize%3Dtrue%2Cwidth%3D0.1%2Cxlabel%3D%22Channel.fromPath%22%5D%3B%0D%0Ap1%20%5Blabel%3D%22analyzeAndAlign%22%5D%3B%0D%0Ap0%20-%3E%20p1%3B%0D%0A%0D%0Ap1%20%5Blabel%3D%22analyzeAndAlign%22%5D%3B%0D%0Ap2%20%5Blabel%3D%22parse%22%5D%3B%0D%0Ap1%20-%3E%20p2%3B%0D%0A%0D%0Ap2%20%5Blabel%3D%22parse%22%5D%3B%0D%0Ap3%20%5Blabel%3D%22processAndDisplay%22%5D%3B%0D%0Ap2%20-%3E%20p3%20%5Blabel%3D%22-%22%5D%3B%0D%0A%0D%0Ap0%20%5Bshape%3Dpoint%2Clabel%3D%22%22%2Cfixedsize%3Dtrue%2Cwidth%3D0.1%2Cxlabel%3D%22Channel.fromPath%22%5D%3B%0D%0Ap3%20%5Blabel%3D%22processAndDisplay%22%5D%3B%0D%0Ap0%20-%3E%20p3%20%5Blabel%3D%22in_folder%22%5D%3B%0D%0A%0D%0Ap3%20%5Blabel%3D%22processAndDisplay%22%5D%3B%0D%0Ap4%20%5Bshape%3Dcircle%2Clabel%3D%22%22%2Cfixedsize%3Dtrue%2Cwidth%3D0.1%2Cxlabel%3D%22view%22%5D%3B%0D%0Ap3%20-%3E%20p4%20%5Blabel%3D%22-%22%5D%3B%0D%0A%0D%0Ap4%20%5Bshape%3Dcircle%2Clabel%3D%22%22%2Cfixedsize%3Dtrue%2Cwidth%3D0.1%2Cxlabel%3D%22view%22%5D%3B%0D%0Ap5%20%5Bshape%3Dpoint%5D%3B%0D%0Ap4%20-%3E%20p5%3B%0D%0A%0D%0A%7D)  
Визуализация отличается за счет того, что процессы внутри пайплайна в основном исполняют несколько инструкций из блок-схемы с алгоритмом. Кроме того, каждый процесс обладает input-ами и output-ами - по сути, входными и выходными каналами, которые являются важной частью всех процессов в NextFlow. Эта специфика отражена в полученном графе, но не в блок-схеме 

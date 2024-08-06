#!/bin/bash  
URL="http://guvi.in"  
HTTP_STATUS=$(curl -o /dev/null -s -w "%{http_code}" "$URL")  
 
echo "HTTP Status Code: $HTTP_STATUS"  

if [[ $HTTP_STATUS -ge 200 && $HTTP_STATUS -lt 300 ]]; then  
    echo "Success: The request was successful."  
else  
    case $HTTP_STATUS in  
        400)  
            echo "Error 400: Bad Request"  
            ;;  
        401)  
            echo "Error 401: Unauthorized"  
            ;;  
        403)  
            echo "Error 403: Forbidden"  
            ;;    
        *)  
            echo "Error $HTTP_STATUS: An unexpected error occurred."  
            ;;  
    esac  
fi
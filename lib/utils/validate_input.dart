
String? validateLogin (String? value, String message){
    if (value == null || value.isEmpty){
          return message;
    }
    return null ;
}

String ? validateFormFields (String? value, bool isNumberInput){
               if (value == null || value.isEmpty) {
                 return "ce champ est requis" ;
               }
               if(isNumberInput && value != '0'){
                  try {
                     int intValue = int.parse(value);
                     if (intValue<0){
                       return "valeur incorrect";
                     }
                  }catch(error){
                    return "entrez des  valeurs numériques pour ce champ";
                  }
               } else {
                 return null;
               }

}
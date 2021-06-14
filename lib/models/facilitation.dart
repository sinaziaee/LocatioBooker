import 'package:flutter/cupertino.dart';
import 'package:loctio_booker/static_methods.dart';

class Facilitation {
  bool refrigerator,
      hairDryer,
      telephone,
      safeBox,
      oven,
      television,
      microwave,
      coffeeMaker,
      airConditioner,
      hotWater,
      furniture,
      cookingBasics,
      wifi,
      parking,
      bathroomEssentials,
      dishWasher,
        pool,
  fireplace,
      washingMachine;

  Facilitation(
      {this.refrigerator,
          @required  this.pool,
          @required  this.fireplace,
      this.hairDryer,
      this.telephone,
      this.safeBox,
      this.oven,
      this.television,
      this.microwave,
      this.coffeeMaker,
      this.hotWater,
      this.furniture,
      this.airConditioner,
      this.dishWasher,
      this.bathroomEssentials,
      this.cookingBasics,
      this.parking,
      this.wifi,
      this.washingMachine});

  static String getImage(String item){
      String result = 'assets/images/facilitation';
      if(item == 'Refrigerator'){
          result = '$result/i-fridge';
      }
      else if(item == "Furniture"){
          result = '$result/i-sofa';
      }
      else if(item == "Air-conditioner"){
          result = '$result/i-fan';
      }
      else if(item == "Hair dryer"){
          result = '$result/i-hair-dryer';
      }
      else if(item == "Phone"){
          result = '$result/i-telephone';
      }
      else if(item == "Safe"){
          result = '$result/i-safe-box';
      }
      else if(item == "Hot water"){
          result = '$result/i-water';
      }
      else if(item == "Pool"){
          result = '$result/i-pool';
      }
      else if(item == "Cooking basics"){
          result = '$result/i-chef';
      }
      else if(item == "TV"){
          result = '$result/i-tv';
      }
      else if(item == "Wifi"){
          result = '$result/i-wifi';
      }
      else if(item == "Parking"){
          result = '$result/i-parking';
      }
      else if(item == "Oven"){
          result = '$result/i-fridge';
      }
      else if(item == "Fire place"){
          result = '$result/i-fireplace';
      }
      else if(item == "Bathroom essentials"){
          result = '$result/i-cooker';
      }
      else if(item == "Microwave"){
          result = '$result/i-microwave';
      }
      else if(item == "Washing machine"){
          result = '$result/i-washing-machine';
      }
      else if(item == "Dish washer"){
          result = '$result/i-dish-washer';
      }
      else{
          result = '-1';
      }
      result = '$result.png';
      return result;
  }

  List<String> getItemsList(){
      List<String> items = [];
      if(this.refrigerator == true){
          items.add("Refrigerator");
      }
      else if(this.furniture == true){
          items.add("Furniture");
      }
      else if(this.airConditioner == true){
          items.add("Air-conditioner");
      }
      else if(this.hairDryer == true){
          items.add("Hair dryer");
      }
      else if(this.telephone == true){
          items.add("Phone");
      }
      else if(this.safeBox == true){
          items.add("Safe");
      }
      else if(this.hotWater == true){
          items.add("Hot water");
      }
      else if(this.pool == true){
          items.add("Pool");
      }
      else if(this.cookingBasics == true){
          items.add("Cooking basics");
      }
      else if(this.television == true){
          items.add("TV");
      }
      else if(this.wifi == true){
          items.add("Wifi");
      }
      else if(this.parking == true){
          items.add("Parking");
      }
      else if(this.oven == true){
          items.add("Oven");
      }
      else if(this.fireplace == true){
          items.add("Fire place");
      }
      else if(this.bathroomEssentials == true){
          items.add("Bathroom essentials");
      }
      else if(this.microwave == true){
          items.add("Microwave");
      }
      else if(this.washingMachine == true){
          items.add("Washing machine");
      }
      else if(this.dishWasher == true){
          items.add("Dish washer");
      }

      return items;

  }

}

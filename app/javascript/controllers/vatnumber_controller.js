// import Rails from "@rails/ujs"
// import { Controller } from "stimulus"

// export default class extends Controller {
  

//   get(e){
//     e.preventDefault()
//     const input = this.element.querySelector('#vat').value 
//     Rails.ajax({
//       type:"get",
//       url:`http://data.gcis.nat.gov.tw/od/data/api/9D17AE0D-09B5-4732-A8F4-81ADED04B679?$format=json&$filter=Business_Accounting_NO eq ${input}&$skip=0&$top=50`,
//       dataType:'json',
//       headers: {
//         "Access-Control-Allow-Origin": "*",
//         "Access-Control-Allow-Origin": "http://localhost:3000",
//       },
//       success:(resp)=>{
//         console.log(resp);
//       }

//     })
//   }
// }

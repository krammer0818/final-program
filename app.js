// App = {
//   web3Provider: null,
//   contracts: {},

//   init: function() {
//     // Load pets.
//     return App.initWeb3();
//   },

//   initWeb3: function() {

//     if (typeof web3 !== 'undefined') {
//       App.web3Provider = web3.currentProvider;
//     } else {
//       App.web3Provider = new Web3.prviders.HttpProvider("http://127.0.0.1:3000");
//     }
//     web3 = new Web3(App.web3Provider);

//     return App.initContract();
//   },

//   initContract: function() {
//     $.getJSON('Adoption.json', function(data) {
//       var AdoptionArtifact = data;

//       App.contracts.Adoption = TruffleContract(AdoptionArtifact);
//       App.contracts.Adoption.setProvider(App.web3Provider);

//       return App.markAdopted();
//     });

//     return App.bindEvents();
//   },

//   bindEvents: function() {
//     $(document).on('click', '.btn-adopt', App.handleAdopt);
//   },

//   markAdopted: function(adopters, account) {
    
//     var apotionInstance;
//     App.contracts.Adoption.deployed().then(function(instance) {
//       apotionInstance = instance;
//       return apotionInstance.getAdopters.call();
//     }).then(function(adopters) {
      
//       for(i =0; i< adopters.length; i++) {
//         console.log(adopters[i]);
//         if(adopters[i] !== '0x0000000000000000000000000000000000000000') {
//           $('.panel-pet').eq(i).find('button').text('Success').attr('disabled', true);
//         }
//       }
//     }).catch(function(err) {
//       console.log(err.message);
//     })
//   },

//   handleAdopt: function(event) {
//     event.preventDefault();
//     var apotionInstance;
//     var petId = parseInt($(event.target).data('id'));

//     web3.eth.getAccounts(function(error, accounts){
//       var account = accounts[0];

//       App.contracts.Adoption.deployed().then(function(instance){
//         apotionInstance = instance;

//         return apotionInstance.adopt(petId, {from: account});
//       }).then(function(result) {
//         return App.markAdopted();
//       } ).catch(function(err) {
//         console.log(err.message);
//       });
//     });
//   }
// };

// $(function() {
//   $(window).load(function() {
//     App.init();
//   });
// });

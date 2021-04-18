// !function(t){
//   t.add("plugin","inlinebutton",{
//     init:function(t){
//       this.app=t,
//       this.opts=t.opts,
//       this.component=t.component,
//       this.links=[]
//     },
//     onmodal:{
//       link:{
//         open: function(t,i){
//           this.opts.definedlinks&&(this.$modal=t,this.$form=i,this._load())
//         }
//       }
//     },
//     _load:function(){
//       "object"==typeof this.opts.definedlinks?this._build(this.opts.definedlinks):t.ajax.get({url:this.opts.definedlinks,success:this._build.bind(this)})
//     },
//     _build:function(i){
//       if(0===(e=this.$modal.find("#redactor-defined-links")).length){
//         var n=this.$modal.getBody(),s=t.dom('<div class="form-item" />'),e=t.dom('<select id="redactor-defined-links" />');s.append(e),n.prepend(s)
//       }
//       for(var o in this.links=[],e.html(""),
//         e.off("change"),i)
//         if(i.hasOwnProperty(o)&&"object"==typeof i[o]){
//           this.links[o]=i[o];var d=t.dom("<option>");d.val(o),d.html(i[o].name),e.append(d)
//         }
//         e.on("change",this._select.bind(this))
//       },
//     _select:function(i){
//       var n=this.$form.getData(),s=t.dom(i.target).val(),e={text:"",url:""};"0"!==s&&(e.text=this.links[s].name,e.url=this.links[s].url),""!==n.text&&(e={url:e.url}),this.$form.setData(e)
//     }
//   })
// }(Redactor);



(function($R)
{
  $R.add('plugin', 'inlinebutton', {
    // set translations
    translations: {
      en: {
        "my-button": "My button"
      }
    },
    init: function(app) {
      this.app = app;
      this.toolbar = app.toolbar;

      // define lang service
      this.lang = app.lang;
    },
    start: function(){
      // set up the button with lang variable
      var buttonData = {
        title: this.lang.get('my-button'),
        api: 'plugin.craftElementLinks.setLinkOptions'
      };

      // add the button to the toolbar
      var $button = this.toolbar.addButton('my-button', buttonData);
    },
    toggle: function(){
      this.app.api('module.link.open');
    },
    onlink: {
      inserted: function(link)
      {
        console.log('TOEGEVOEGD');
      }
    }
    
  });
})(Redactor);
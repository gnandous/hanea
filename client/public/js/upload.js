
(function(){

  window.HAUpload = (function(){

    HAUpload.prototype.name = "ObjectnNmae";
    HAUpload.prototype.url = "/signPut";
    HAUpload.prototype.file_dom_selector = "file_upload";
    HAUpload.prototype.fileType = null;

    HAUpload.prototype.onFinishPut= function(public_url){
      return console.log(public_url);
    };
    HAUpload.prototype.onProgress = function(percent, status) {
      return console.log(percent, status);
    };
    HAUpload.prototype.onError = function(status) {
      return console.log(status);
    };

    function HAUpload(options){
      if (options == null) options = {};
      for (option in options){
        this[option] = options[option];
      }
      this.handleFileSelect(document.getElementById(this.file_dom_selector));
    }

    HAUpload.prototype.executeOnSignedUrl = function(file){
      var this_upload, xhr, form;

      this_upload = this;
      form = new FormData();

      xhr = new XMLHttpRequest();
      xhr.open("POST", this_upload.url);
      xhr.onload = function(){
        if (xhr.status === 200) {
          this_upload.onProgress(100, 'Upload completed.');
        } else{
          return this_upload.onError('Upload error: ' + xhr.status);
        }
      };

      xhr.onerror = function() {
        return this_upload.onError('XHR error.');
      };

      xhr.upload.onprogress = function(e) {
        var percentLoaded;
        if (e.lengthComputable) {
          percentLoaded = Math.round((e.loaded / e.total) * 100);
          return this_upload.onProgress(percentLoaded, percentLoaded === 100 ? 'Finalizing.' : 'Uploading.');
        }
      };
      form.append('file', file);
      return xhr.send(form);
    };

    HAUpload.prototype.handleFileSelect = function(file_element){
      var f, files, output, _i, _len, _results;
      this.onProgress(0, 'Upload started');
      files = file_element.files;
      output = [];
      _results = [];
      for (_i = 0, _len = files.length; _i < _len; _i++){
        f = files[_i];
        _results.push(this.uploadFile(f));
      }
      return _results;
    };

    HAUpload.prototype.uploadFile = function(file){
      this.executeOnSignedUrl(file);
    };

    return HAUpload;

  })();

}).call(this);

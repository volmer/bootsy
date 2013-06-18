window.Bootsy = window.Bootsy || {};

window.Bootsy.Area = function($el) {
  var self = this;

  this.progressBar = function(element){
    element.find('div.modal-body').html('<div class="progress progress-striped active"><div class="bar" style="width: 100%;"></div></div>');
  };

  this.refreshGallery = function(element){
    element.find('a.refresh_btn').show().click();
  };

  this.openImageGallery = function(editor){
    editor.currentView.element.focus(false);
    self.caretBookmark = editor.composer.selection.getBookmark();
    $('#bootsy_image_gallery').modal('show');
  };

  this.insertImage = function(image){
    $('#bootsy_image_gallery').modal('hide');
    self.editor.currentView.element.focus();
    if (self.caretBookmark) {
      self.editor.composer.selection.setBookmark(self.caretBookmark);
      self.caretBookmark = null;
    }
    self.editor.composer.commands.exec('insertImage', image);
  };

  this.on = function(eventName, callback){
    self.eventCallbacks[eventName].push(callback);
  };

  this.trigger = function(eventName){
    var callbacks = self.eventCallbacks[eventName];
    for(i in callbacks){
      callbacks[i]();
    }
    self.triggeredEvents.push(eventName);
  };

  this.after = function(eventName, callback){
    if(self.triggeredEvents.indexOf(eventName) != -1){
      callback();
    }else{
      self.on(eventName, callback);
    }
  };

  this.alertUnsavedChanges = function() {
    if (self.unsavedChanges) {
      return Bootsy.translations[self.locale].alert_unsaved;
    }
  };

  this.locale = $el.data('bootsy-locale') || $('html').attr('lang') || 'en';
  this.caretBookmark = false;
  this.unsavedChanges = false;
  this.editor = false;
  this.eventCallbacks = {'loaded': []};
  this.triggeredEvents = [];
  this.editorOptions = {locale: this.locale};

  if ($el.data('bootsy-font-styles') === false) this.editorOptions['font-styles'] = false;
  if ($el.data('bootsy-emphasis') === false) this.editorOptions.emphasis = false;
  if ($el.data('bootsy-lists') === false) this.editorOptions.lists = false;
  if ($el.data('bootsy-html') === true) this.editorOptions.html = true;
  if ($el.data('bootsy-link') === false) this.editorOptions.link = false;
  if ($el.data('bootsy-color') === false) this.editorOptions.color = false;

  if ($el.data('bootsy-alert-unsaved') !== false) {
    window.onbeforeunload = this.alertUnsavedChanges;
  }

  $el.closest('form').submit(function(e) {
    self.unsavedChanges = false;
    return true;
  });

  if ($el.data('bootsy-image') !== false) {
    if ($el.data('bootsy-uploader') !== false) {
      this.editorOptions.image = false;
      this.editorOptions.customCommand = true;
      this.editorOptions.customCommandCallback = this.openImageGallery;
      this.editorOptions.customTemplates = {
        customCommand: function(locale, options) {
          var size = (options && options.size) ? ' btn-'+options.size : '';
          return "<li>" +
            "<a class='btn" + size + "' data-wysihtml5-command='customCommand' title='" + locale.image.insert + "' tabindex='-1'><i class='icon-picture'></i></a>" +
          "</li>";
        }
      };

      element = $('#bootsy_image_gallery');

      element.parents('form').after(element);

      element.on('click', 'a.refresh_btn', function(e){
        $(this).hide();
        self.progressBar(element);
      });

      element.find('a.destroy_btn').click(function(e){
        self.progressBar(element);
      });

      element.modal({show: false});
      element.on('shown', function(){
        self.refreshGallery(element);
      });

      element.on('hide', function() {
        self.editor.currentView.element.focus();
      });

      element.on('click.dismiss.modal', '[data-dismiss="modal"]', function(e) {
        e.stopPropagation();
      });

      element.on('click', 'ul.dropdown-menu a.insert', function(e){
        var imagePrefix = "/"+$(this).attr('data-image-size')+"_";
        if($(this).data('image-size') == 'original'){
          imagePrefix = '/';
        }
        var img = $(this).parents('li.dropdown').find('img');
        var obj = {
          src: img.attr('src').replace("/thumb_", imagePrefix),
          alt: img.attr('alt').replace("Thumb_", "")
        };

        obj.align = $(this).data('position');

        self.insertImage(obj);
      });
    }
  } else {
    this.editorOptions.image = false;
  }

  this.editor = $el.wysihtml5($.extend(Bootsy.editorOptions, this.editorOptions)).data('wysihtml5').editor;

  this.editor.on('change', function() {
    self.unsavedChanges = true;
  });

  this.trigger('loaded');
};

require 'rails_helper'

describe Bootsy::FormHelper do
  let(:view) { ActionView::Base.new }
  let(:options) { {} }

  before do
    allow(view).to receive(:render).with(
      'bootsy/images/modal', anything).and_return('bootsy-modal')
  end

  describe '#bootsy_area' do
    subject { view.bootsy_area(:post, :content, options) }

    it 'renders a trix-editor with .bootsy_text_area and .trix-content' do
      expect(subject).to match(
        %r{<trix-editor .*class="bootsy_text_area trix-content"></trix-editor>})
    end

    it 'renders a hidden input for the actual model attribute' do
      expect(subject).to match(
        %r{<input id="trix-editor-\d+" type="hidden" name="post\[content\]" />})
    end

    it 'renders the hidden input with an unique id everytime it is called' do
      id_1 = /id="trix-editor-(\d+)"/.match(
        view.bootsy_area(:post, :content)).captures.first
      id_2 = /id="trix-editor-(\d+)"/.match(
        view.bootsy_area(:post, :content)).captures.first

      expect(id_1).not_to eq(id_2)
    end

    context 'when no object is passed' do
      it 'adds data-uploader="false"' do
        expect(subject).to match(
          %r{<trix-editor .*data-uploader="false".*></trix-editor>})
      end

      it 'does not render the upload modal' do
        expect(subject).not_to include('bootsy-modal')
      end
    end

    context 'with an object' do
      let(:options) { { object: object } }

      context 'when the object is a Bootsy Container' do
        let(:object) { Post.new(content: 'Content') }

        it 'renders a hidden field with class and name bootsy_image_gallery_id' do
          expect(subject).to match(
            %r{<input class="bootsy_image_gallery_id" type="hidden" name="post\[bootsy_image_gallery_id\]" id=".*" />})
        end

        it 'renders the upload modal' do
          expect(subject).to include('bootsy-modal')
        end

        it 'does not pass the object to the trix-editor' do
          expect(subject).not_to match(/object/)
        end

        it 'creates an image gallery for it' do
          expect { subject }.to change { object.bootsy_image_gallery.present? }
            .from(false).to(true)
        end

        it 'includes the gallery id in the data attributes' do
          subject
          id = object.bootsy_image_gallery.id
          expect(subject).to match(
            %r{<trix-editor .*data-gallery-id="#{id}".*></trix-editor>})
        end

        it 'renders the hidden input vith the value from the object' do
          expect(subject).to match(
            %r{<input id="trix-editor-\d+" type="hidden" value="Content" name="post\[content\]" />})
        end

        context 'when uploader: false is passed' do
          let(:options) { { object: object, uploader: false } }

          it 'adds data-uploader="false"' do
            expect(subject).to match(
              %r{<trix-editor .*data-uploader="false".*></trix-editor>})
          end

          it 'does not render the upload modal' do
            expect(subject).not_to include('bootsy-modal')
          end
        end
      end

      context 'when object is not a Bootsy Container' do
        let(:object) { Comment.new }

        it 'adds data-uploader="false"' do
          expect(subject).to match(
            %r{<trix-editor .*data-uploader="false".*></trix-editor>})
        end

        it 'does not render the upload modal' do
          expect(subject).not_to include('bootsy-modal')
        end

        context 'when a specific container is passed' do
          let(:container) { Post.new }

          let(:options) { { object: object, container: container } }

          it 'renders the upload modal' do
            expect(subject).to include('bootsy-modal')
          end

          it 'does not pass the container to the trix-editor' do
            expect(subject).not_to match(/container/)
          end

          it 'creates an image gallery for it' do
            expect { subject }
              .to change { container.bootsy_image_gallery.present? }
              .from(false).to(true)
          end

          it 'includes the gallery id in the data attributes' do
            subject
            id = container.bootsy_image_gallery.id
            expect(subject).to match(
              %r{<trix-editor .*data-gallery-id="#{id}".*></trix-editor>})
          end

          context 'when the specific container is not a Container' do
            let(:container) { Comment.new }

            it 'adds data-uploader="false"' do
              expect(subject).to match(
                %r{<trix-editor .*data-uploader="false".*></trix-editor>})
            end

            it 'does not render the upload modal' do
              expect(subject).not_to include('bootsy-modal')
            end
          end
        end
      end
    end

    context 'when editor options are passed' do
      let(:options) do
        { editor_options: { op1: '1', op2: '2' } }
      end

      it 'forwards them to the trix editor as data attributes' do
        expect(subject).to match(
          %r{<trix-editor .*data-op1="1".*></trix-editor>})

        expect(subject).to match(
          %r{<trix-editor .*data-op2="2".*></trix-editor>})
      end
    end

    context 'when editor options are defined on the intialize file' do
      before do
        allow(Bootsy).to receive(:editor_options).and_return(g1: 1, g2: 2)
      end

      it 'forwards them to the trix editor as data attributes' do
        expect(subject).to match(
          %r{<trix-editor .*data-g1="1".*></trix-editor>})

        expect(subject).to match(
          %r{<trix-editor .*data-g2="2".*></trix-editor>})
      end
    end

    context 'when additional options are passed' do
      let(:options) do
        { op1: '1', op2: '2', data: { a: 1, b: 2 }, uploader: false }
      end

      it 'forwards them to the trix editor' do
        expect(subject).to match(
          %r{<trix-editor.* op1="1".*></trix-editor>})

        expect(subject).to match(
          %r{<trix-editor.* op2="2".*></trix-editor>})

        expect(subject).to match(
          %r{<trix-editor .*data-a="1".*></trix-editor>})

        expect(subject).to match(
          %r{<trix-editor .*data-b="2".*></trix-editor>})
      end

      it 'forwards the uploader option as a data attribute' do
        expect(subject).to match(
          %r{<trix-editor .*data-uploader="false".*></trix-editor>})
      end
    end

    context 'when custom HTML classes are passed' do
      context 'as a string' do
        let(:options) do
          { class: 'class1 class2' }
        end

        it 'forwards them to the trix editor' do
          expect(subject).to match(
            %r{<trix-editor .*class="class1 class2 bootsy_text_area trix-content".*></trix-editor>})
        end
      end

      context 'as an array' do
        let(:options) do
          { class: ['class1', 'class2'] }
        end

        it 'forwards them to the trix editor' do
          expect(subject).to match(
            %r{<trix-editor .*class="class1 class2 bootsy_text_area trix-content".*></trix-editor>})
        end
      end
    end
  end
end

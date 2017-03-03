# frozen_string_literal: true
require 'rails_helper'

describe Bootsy::FormHelper do
  let(:view) { ActionView::Base.new }
  let(:options) { {} }

  before do
    allow(view).to receive(:render)
      .with('bootsy/images/modal', anything).and_return('bootsy-modal')
  end

  describe '#bootsy_area' do
    subject { view.bootsy_area(:post, :content, options) }

    it 'renders a text_area with class bootsy_text_area' do
      expect(view).to receive(:text_area)
        .with(:post, :content, hash_including(class: ['bootsy_text_area']))
        .and_call_original

      subject
    end

    context 'when no object is passed' do
      it 'adds data-bootsy-uploader="false"' do
        expect(view).to receive(:text_area).with(
          :post, :content,
          hash_including(data: hash_including('bootsy-uploader' => false))
        ).and_call_original

        subject
      end

      it 'does not render the upload modal' do
        expect(subject).not_to include('bootsy-modal')
      end
    end

    context 'with an object' do
      let(:options) { { object: object } }

      context 'when the object is a Bootsy Container' do
        let(:object) { Post.new }

        it 'renders a hidden_field with class bootsy_image_gallery_id' do
          expect(view).to receive(:hidden_field).with(
            :post, :bootsy_image_gallery_id, class: 'bootsy_image_gallery_id'
          ).and_call_original

          subject
        end

        it 'renders the upload modal' do
          expect(subject).to include('bootsy-modal')
        end

        it 'creates an image gallery for it' do
          expect do
            subject
          end.to change {
            object.bootsy_image_gallery.present?
          }.from(false).to(true)
        end

        it 'includes the gallery id in the data attributes' do
          expect(view).to receive(:text_area).with(
            :post, :content, hash_including(data: hash_including(:gallery_id))
          ).and_call_original

          subject
        end

        context 'when uploader: false is passed' do
          let(:options) { { object: object, uploader: false } }

          it 'adds data-bootsy-uploader="false"' do
            expect(view).to receive(:text_area).with(
              :post,
              :content,
              hash_including(data: hash_including('bootsy-uploader' => false))
            ).and_call_original

            subject
          end

          it 'does not render the upload modal' do
            expect(subject).not_to include('bootsy-modal')
          end

          it 'does not pass the uploader option to the text area helper' do
            expect(view).to receive(:text_area)
              .with(anything, anything, hash_excluding(:uploader))
              .and_call_original

            subject
          end
        end
      end

      context 'when object is not a Bootsy Container' do
        let(:object) { Comment.new }

        subject { view.bootsy_area(:comment, :content, options) }

        it 'adds data-bootsy-uploader="false"' do
          expect(view).to receive(:text_area).with(
            :comment,
            :content,
            hash_including(data: hash_including('bootsy-uploader' => false))
          ).and_call_original

          subject
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

          it 'does not pass the container to the text area helper' do
            expect(view).to receive(:text_area).with(
              anything, anything, hash_excluding(:container)
            ).and_call_original

            subject
          end

          it 'creates an image gallery for it' do
            expect do
              subject
            end.to change {
              container.bootsy_image_gallery.present?
            }.from(false).to(true)
          end

          it 'includes the gallery id in the data attributes' do
            expect(view).to receive(:text_area).with(
              :comment,
              :content,
              hash_including(data: hash_including(:gallery_id))
            ).and_call_original

            subject
          end

          context 'when the specific container is not a Container' do
            let(:container) { Comment.new }

            it 'adds data-bootsy-uploader="false"' do
              expect(view).to receive(:text_area).with(
                :comment,
                :content,
                hash_including(data: hash_including('bootsy-uploader' => false))
              ).and_call_original

              subject
            end

            it 'does not render the upload modal' do
              expect(subject).not_to include('bootsy-modal')
            end
          end
        end
      end
    end

    context 'when editor_options are passed' do
      let(:options) do
        { editor_options: { op1: '1', op2: '2' } }
      end

      it 'passes editor options to the text area as data-bootsy attributes' do
        expect(view).to receive(:text_area).with(
          :post,
          :content,
          hash_including(
            data: hash_including('bootsy-op1' => '1', 'bootsy-op2' => '2')
          )
        ).and_call_original

        subject
      end

      it 'does not pass the uploader option to the text area helper' do
        expect(view).to receive(:text_area)
          .with(anything, anything, hash_excluding(:editor_options))
          .and_call_original

        subject
      end
    end

    context 'when editor options are defined on the intialize file' do
      before do
        allow(Bootsy).to receive(:editor_options)
          .and_return(global1: 1, global2: 2)
      end

      it 'passes them to the text area as data-bootsy attributes' do
        expect(view).to receive(:text_area).with(
          :post,
          :content,
          hash_including(
            data: hash_including('bootsy-global1' => 1, 'bootsy-global2' => 2)
          )
        ).and_call_original

        subject
      end
    end

    context 'when additional options are passed' do
      let(:options) do
        { op1: '1', op2: '2', data: { a: 1, b: 2 } }
      end

      it 'resends them to the text_area' do
        expect(view).to receive(:text_area).with(
          :post,
          :content,
          hash_including(op1: '1', op2: '2', data: hash_including(a: 1, b: 2))
        ).and_call_original

        subject
      end
    end

    context 'when custom HTML classes are passed' do
      context 'as a string' do
        let(:options) do
          { class: 'class1 class2' }
        end

        it 'resends them to the text_area' do
          expect(view).to receive(:text_area).with(
            :post,
            :content,
            hash_including(class: ['class1 class2', 'bootsy_text_area'])
          ).and_call_original

          subject
        end
      end

      context 'as an array' do
        let(:options) do
          { class: %w(class1 class2) }
        end

        it 'resends them to the text_area' do
          expect(view).to receive(:text_area).with(
            :post,
            :content,
            hash_including(class: %w(class1 class2 bootsy_text_area))
          ).and_call_original

          subject
        end
      end
    end
  end
end

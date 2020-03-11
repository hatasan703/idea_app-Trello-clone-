<template>
  <div class="idea_edit">
    <div>
    <h6 @click="editing=true" class="idea_content">{{ content }} <i class="fa fa-edit" aria-hidden="true"></i></h6>

    </div>
    <div v-if='editing' class="modal-backdrop show"></div>
    <div v-if='editing' @click="closeModal" class="modal show" style="display: block">
      <div class="modal-dialog">
        <div class="modal-content">
          <div class="modal-header">
            <h5 class="modal-title">{{ content }}</h5>
          </div>
          <div class="modal-body">
            <textarea v-model="content" class="form-control content_form"></textarea>
          </div>
          <div class="modal-footer">
            <button @click="save" type="button" class="btn btn-primary">保存</button>
            <button @click="destroy" type="button" class="btn btn-primary">削除</button>
          </div>
        </div>
      </div>
    </div>
  </div>
</template>



<script>
export default {
  props: ['idea'],
  data: function() {
    return {
      editing: false,
      content: this.idea.content,
    }
  },

  methods: {
    // アイディア(content)編集（モーダル）
    closeModal: function(event) {
      if (event.target.classList.contains("modal")) { this.editing = false }
    },

    save: function() {
      var data = new FormData
      data.append("idea[content]", this.content)

      Rails.ajax({
        beforeSend: () => true,
        url: `/ideas/${this.idea.id}`,
        type: "PATCH",
        data: data,
        dataType: "json",
        success: (data) => {
          const idea_index = window.store.ideas.findIndex((item) => item.id == this.idea.id)
          window.store.ideas.splice(idea_index, 1, data)
          this.editing = false
        }
      })
    },
    
    // アイディア削除
     destroy: function() {
      var data = new FormData
      data.append("idea[content]", this.content)

      Rails.ajax({
        beforeSend: () => true,
        url: `/ideas/${this.idea.id}`,
        type: "DELETE",
        data: data,
        dataType: "json",
        success: (data) => {
          const idea_index = window.store.ideas.findIndex((item) => item.id == this.idea.id)
          window.store.ideas.splice(idea_index, 1)
          this.editing = false
        }
      })
    },

  }
}
</script>


<style lang="scss" scoped>
@import "../assets/test.scss";

.idea_content{
  word-wrap: break-word;
}

/* .content_form{
  height: 200px;
} */
</style>
<template>
  <div class="idea_edit">
    <div @click="editing=true">編集</div>
    <div v-if='editing' class="modal-backdrop show"></div>
    <div v-if='editing' @click="closeModal" class="modal show" style="display: block">
      <div class="modal-dialog">
        <div class="modal-content">
          <div class="modal-header">
            <h5 class="modal-title">{{ ideaEdit.content }}</h5>
          </div>
          <div class="modal-body">
            <input v-model="content" class="form-control"></input>
          </div>
          <div class="modal-footer">
            <button @click="save" type="button" class="btn btn-primary">Save changes</button>
            <button @click="destroy" type="button" class="btn btn-primary">Delete</button>
          </div>
        </div>
      </div>
    </div>
  </div>
</template>



<script>
export default {
  props: ['ideaEdit','idea'],
  data: function() {
    return {
      editing: false,
      content: this.ideaEdit.content,
    }
  },

  methods: {
    // リスト(content)編集（モーダル）
    closeModal: function(event) {
      if (event.target.classidea.contains("modal")) { this.editing = false }
    },

    save: function() {
      var data = new FormData
      data.append("idea[content]", this.content)

      Rails.ajax({
        beforeSend: () => true,
        url: `/ideas/${this.ideaEdit.id}`,
        type: "PATCH",
        data: data,
        dataType: "json",
        success: (data) => {
          const idea_index = window.store.ideas.findIndex((item) => item.id == this.ideaEdit.id)
          window.store.ideas.splice(idea_index, 1, data)
          this.editing = false
        }
      })
    },
    
    // リスト削除
     destroy: function() {
      var data = new FormData
      data.append("idea[content]", this.content)

      Rails.ajax({
        beforeSend: () => true,
        url: `/ideas/${this.ideaEdit.id}`,
        type: "DELETE",
        data: data,
        dataType: "json",
        success: (data) => {
          const idea_index = window.store.ideas.findIndex((item) => item.id == this.ideaEdit.id)
          window.store.ideas.splice(idea_index, 1)
          this.editing = false
        }
      })
    },

  }
}
</script>

<style scoped>
</style>
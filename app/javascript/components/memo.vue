<template>
<!-- カード編集フォーム (モーダルウインドウ)-->
<div>
  <div @click="editing=true" class="card card-body mb-3">
    {{ memo.content }}
  </div> 
  <div v-if='editing' class="modal-backdrop show"></div>

  <div v-if='editing' @click="closeModal" class="modal show" style="display: block">
    <div class="modal-dialog">
        <div class="modal-content">
          <div class="modal-header">
            <h5 class="modal-title">{{ memo.content }}</h5>
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
  props: ['memo', 'idea'],
  data: function() {
    return {
      editing: false,
      content: this.memo.content,
    }
  },

  methods: {
    // カード(content)編集（モーダル）
    closeModal: function(event) {
      if (event.target.classidea.contains("modal")) { this.editing = false }
    },

    save: function() {
      var data = new FormData
      data.append("memo[content]", this.content)

      Rails.ajax({
        url: `/memos/${this.memo.id}`,
        type: "PATCH",
        data: data,
        dataType: "json",
        success: (data) => {
          const idea_index = window.store.ideas.findIndex((item) => item.id == this.idea.id)
          const memo_index = window.store.ideas[idea_index].memos.findIndex((item) => item.id == this.memo.id)
          window.store.ideas[idea_index].memos.splice(memo_index, 1, data)

          this.editing = false
        }
      })
    },

    destroy: function() {
      var data = new FormData
      data.append("memo[content]", this.content)

      Rails.ajax({
        url: `/memos/${this.memo.id}`,
        type: "DELETE",
        data: data,
        dataType: "json",
        success: (data) => {
          const idea_index = window.store.ideas.findIndex((item) => item.id == this.idea.id)
          const memo_index = window.store.ideas[idea_index].memos.findIndex((item) => item.id == this.memo.id)
          window.store.ideas[idea_index].memos.splice(memo_index, 1)

          this.editing = false
        }
      })
    }
  }
}
</script>

<style scoped>
</style>
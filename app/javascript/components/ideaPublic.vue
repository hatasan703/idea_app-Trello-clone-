<template>
  <div>
    <comment v-for="idea in ideas" :key="idea.id" :idea="idea" :comment="comment">
      <!-- <div class="idea idea_content">
        <div>{{ idea.content }}</div>

        <div class="comment_form">
          <a v-if="!editing" v-on:click="startEditing"><i class="fa fa-plus-circle" aria-hidden="true"></i>コメントを追加</a>
          <textarea v-if="editing" ref="message" v-model="message" class="form-control mb-1 content_form"></textarea>
          <button v-if="editing" v-on:click="" class="btn btn-secondary">コメントを追加</button>
          <a v-if="editing" v-on:click="editing=false">キャンセル</a>
        </div>
      </div> -->
    </comment>
  </div>
</template>

<script>
import comment from 'components/comment'

export default {
  components: { comment },
  props: ["comment_ideas"],
  data: function() {
    return{
      ideaPublic: this.comment_ideas,
      ideas: this.comment_ideas,
      editing: false,
      message: "",
    }
  },

}
</script>



<style>

</style>
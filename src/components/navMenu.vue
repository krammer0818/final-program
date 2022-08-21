<template>
  <div>
    <div class="menu">
      <el-radio-group v-model="isCollapse" style="margin-bottom: 20px">
        <el-radio-button :label="false">unfold</el-radio-button>
        <el-radio-button :label="true">merge</el-radio-button>
      </el-radio-group>
      <el-menu
        default-active="1-4-1"
        class="el-menu-vertical-demo"
        @open="handleOpen"
        @close="handleClose"
        :collapse="isCollapse"
      >
        <el-submenu index="1">
          <template slot="title">
            <i class="el-icon-edit"></i>
            <span slot="title">register</span>
          </template>
          <el-menu-item-group>
            <span slot="title">type</span>
            <el-menu-item index="1-1" @click="petDialogVisible = true"
              >pet registration</el-menu-item
            >
            <el-menu-item index="1-2" @click="userDialogVisible = true"
              >user registration</el-menu-item
            >
          </el-menu-item-group>
        </el-submenu>
        <!-- <el-menu-item index="2">
          <i class="el-icon-document"></i>
          <span slot="title">help</span>
        </el-menu-item> -->
        <el-menu-item index="2" @click="devDialogVisible = true">
          <i class="el-icon-medal-1"></i>
          <span slot="title">Update log</span>
        </el-menu-item>
      </el-menu>
    </div>
    <div>
      <el-dialog
        title="Information"
        :visible.sync="petDialogVisible"
        width="30%"
      >
        <el-form ref="form" :model="petForm" label-width="100px">
          <el-form-item label="Name">
            <el-input v-model="petForm.name"></el-input>
          </el-form-item>
          <el-form-item label="Age">
            <el-input v-model="petForm.age"></el-input>
          </el-form-item>
          <el-form-item label="Breed">
            <el-input v-model="petForm.breed"></el-input>
          </el-form-item>
          <el-form-item label="Address">
            <el-input v-model="petForm.region"></el-input>
          </el-form-item>
          <el-form-item label="Health">
            <el-switch v-model="petForm.health"></el-switch>
          </el-form-item>
          <el-form-item label="Lost">
            <el-switch v-model="petForm.lost"></el-switch>
          </el-form-item>
          <el-form-item label="Birth">
            <el-date-picker type="date" placeholder="select a date">
            </el-date-picker>
          </el-form-item>
          <el-form-item label="Certificate">
            <el-upload
              class="upload-demo"
              drag
              action="https://jsonplaceholder.typicode.com/posts/"
              multiple
            >
              <i class="el-icon-upload"></i>
              <div class="el-upload__text">
                drag the file here or<em>click here</em>
              </div>
              <div class="el-upload__tip" slot="tip">
                Only JPG/PNG files with maximum size of 500kb
              </div>
            </el-upload>
          </el-form-item>
        </el-form>
        <span slot="footer" class="dialog-footer">
          <el-button @click="petDialogVisible = false">Cancel</el-button>
          <el-button type="primary" @click="petDialogVisible = false"
            >Confirm</el-button
          >
        </span>
      </el-dialog>
    </div>
    <div>
      <el-dialog
        title="Information"
        :visible.sync="userDialogVisible"
        width="30%"
      >
        <el-form ref="form" :model="userForm" label-width="80px">
          <el-form-item label="Name">
            <el-input v-model="userForm.name"></el-input>
          </el-form-item>
          <el-form-item label="E-Mail">
            <el-input v-model="userForm.email"></el-input>
          </el-form-item>
        </el-form>
        <span slot="footer" class="dialog-footer">
          <el-button @click="userDialogVisible = false">Cancel</el-button>
          <el-button type="primary" @click="userDialogVisible = false"
            >Confirm</el-button
          >
        </span>
      </el-dialog>
    </div>
    <div>
      <el-dialog title="Timeline" :visible.sync="devDialogVisible" width="30%">
        <el-timeline>
          <el-timeline-item timestamp="2022/8/21" placement="top">
            <el-card>
              <h4>Initial program</h4>
              <p>krammer summited 2022/8/21 16:41</p>
            </el-card>
          </el-timeline-item>
          <el-timeline-item timestamp="2022/8/22" placement="top">
            <el-card>
              <h4>Designed function</h4>
              <p>krammer summited 2022/8/22 20:15</p>
            </el-card>
          </el-timeline-item>
          <el-timeline-item timestamp="2022/8/24" placement="top">
            <el-card>
              <h4>Finish & review</h4>
              <p>krammer summited 2022/8/24 22:58</p>
            </el-card>
          </el-timeline-item>
        </el-timeline>
        <span slot="footer" class="dialog-footer">
          <el-button @click="devDialogVisible = false">Cancel</el-button>
          <el-button type="primary" @click="devDialogVisible = false"
            >Confirm</el-button
          >
        </span>
      </el-dialog>
    </div>
  </div>
</template>
<style>
.el-menu-vertical-demo:not(.el-menu--collapse) {
  width: 200px;
  min-height: 400px;
}
</style>

<script>
export default {
  data() {
    return {
      isCollapse: true,
      petDialogVisible: false,
      userDialogVisible: false,
      devDialogVisible: false,
      petForm: {
        name: "",
        age: "",
        breed: "",
        region: "",
        health: "",
        lost: "",
      },
      userForm: {
        name: "",
        email: "",
      },
    };
  },
  methods: {
    handleOpen(key, keyPath) {
      console.log(key, keyPath);
    },
    handleClose(key, keyPath) {
      console.log(key, keyPath);
    },
  },
};
</script>

<style scoped>
.menu {
  top: 1%;
  position: fixed;
}
</style>
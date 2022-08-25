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
        <el-menu-item index="2" @click="actDialogVisible = true">
          <i class="el-icon-user"></i>
          <span slot="title">Account</span>
        </el-menu-item>
        <el-menu-item index="3" @click="devDialogVisible = true">
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
            <el-input-number
              v-model="petForm.age"
              :min="1"
              :max="15"
            ></el-input-number>
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
          <el-form-item label="Photo">
            <el-upload
              class="upload-demo"
              drag
              action="https://jsonplaceholder.typicode.com/posts/"
              :show-file-list="true"
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
          <el-button type="primary" @click="petDV()"
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
          <el-form-item label="Phone">
            <el-input v-model="userForm.phone"></el-input>
          </el-form-item>
          <el-form-item label="Location">
            <el-input v-model="userForm.location"></el-input>
          </el-form-item>
          <el-form-item label="Postscript">
            <el-input v-model="userForm.email"></el-input>
          </el-form-item>
          <el-form-item label="Address">
            <el-input v-model="userForm.address"></el-input>
          </el-form-item>
        </el-form>
        <span slot="footer" class="dialog-footer">
          <el-button @click="userDialogVisible = false">Cancel</el-button>
          <el-button type="primary" @click="userDV()"
            >Confirm</el-button
          >
        </span>
      </el-dialog>
    </div>

    <div>
      <el-dialog
        title="Information"
        :visible.sync="actDialogVisible"
        width="50%"
      >
<el-descriptions class="margin-top" :column="3" :size="size" border>
    <template slot="extra">
      <el-button type="primary" size="small">Modify</el-button>
    </template>
    <el-descriptions-item>
      <template slot="label">
        <i class="el-icon-user"></i>
        Name
      </template>
      kooriookami
    </el-descriptions-item>
    <el-descriptions-item>
      <template slot="label">
        <i class="el-icon-mobile-phone"></i>
        Phone
      </template>
      18100000000
    </el-descriptions-item>
    <el-descriptions-item>
      <template slot="label">
        <i class="el-icon-location-outline"></i>
        Location
      </template>
      China
    </el-descriptions-item>
    <el-descriptions-item>
      <template slot="label">
        <i class="el-icon-tickets"></i>
        Postscipt
      </template>
    </el-descriptions-item>
    <el-descriptions-item>
      <template slot="label">
        <i class="el-icon-office-building"></i>
        Contact Address
      </template>
      xxxxxxxx
    </el-descriptions-item>
  </el-descriptions>
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
      actDialogVisible: false,
      petForm: {
        name: "",
        age: "1",
        breed: "",
        region: "",
        health: true,
        lost: false,
      },
      userForm: {
        name: "",
        email: "",
        phone: "",
        location: "",
        postscript: "",
        address: ""
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
    petDV() {
      this.petDialogVisible = false
      this.successInfo()
    },
    userDV() {
      this.userDialogVisible = false
      this.successInfo()      
    },
    successInfo() {
      this.$message({
        message: 'Congratulations! Registered successfully',
        type: 'success'
      });
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
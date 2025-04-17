<template>
  <div class="col align-items-center content">
    <!-- Listing Info Header -->
    <div id="listingInfo" class="col mb-4 w-100 align-items-center">
      <h1>{{ listingInfo.name }}</h1>
      <div v-if="listingInfo.description" class="caption1 mb-2">{{ listingInfo.description }}</div>
      <div class="col align-items-center">
        <div class="caption1 mb-2" id="publishedByText">
          Published by <a :href="listingInfo.author.url" target="_blank">{{ listingInfo.author.name }}</a>
        </div>
        <div v-if="listingInfo.infoLink && listingInfo.infoLink.url" class="caption1" id="publishedByText">
          <a :href="listingInfo.infoLink.url" target="_blank">{{ listingInfo.infoLink.text || 'Learn More' }}</a>
        </div>
      </div>
    </div>    <!-- Add to VCC Block -->
    <div class="addToVccBlock mt-4 row align-items-center">
      <!-- <label for="vccUrlField" class="visually-hidden">Repository URL</label> -->
      <input type="text" aria-readonly="true" id="vccUrlField" class="vccUrlField" readonly :value="listingInfo.url">
      <button class="ms-2" id="vccAddRepoButton" aria-label="Add repository to VCC">Add to VCC</button>
      <button class="ms-2" id="vccUrlFieldCopy" aria-label="Copy repository URL">
        <svg slot="start" width="20" height="20" viewBox="0 0 20 20" xmlns="http://www.w3.org/2000/svg" aria-hidden="true" focusable="false">
          <path d="M8 2C6.89543 2 6 2.89543 6 4V14C6 15.1046 6.89543 16 8 16H14C15.1046 16 16 15.1046 16 14V4C16 2.89543 15.1046 2 14 2H8ZM7 4C7 3.44772 7.44772 3 8 3H14C14.5523 3 15 3.44772 15 4V14C15 14.5523 14.5523 15 14 15H8C7.44772 15 7 14.5523 7 14V4ZM4 6.00001C4 5.25973 4.4022 4.61339 5 4.26758V14.5C5 15.8807 6.11929 17 7.5 17H13.7324C13.3866 17.5978 12.7403 18 12 18H7.5C5.567 18 4 16.433 4 14.5V6.00001Z"/>
        </svg>
        Copy
      </button>
      <button id="urlBarHelp" class="ms-2" aria-label="Help with adding to VCC">
        <svg width="20" height="20" viewBox="0 0 20 20" xmlns="http://www.w3.org/2000/svg" aria-hidden="true" focusable="false">
          <path d="M4 4V16C4 17.1046 4.89543 18 6 18H15.5C15.7761 18 16 17.7761 16 17.5C16 17.2239 15.7761 17 15.5 17H6C5.44772 17 5 16.5523 5 16H15C15.5523 16 16 15.5523 16 15V4C16 2.89543 15.1046 2 14 2H6C4.89543 2 4 2.89543 4 4ZM14 3C14.5523 3 15 3.44772 15 4V15H5V4C5 3.44772 5.44772 3 6 3H14ZM8.76069 6.40877C8.95015 6.21142 9.31074 6 10 6C10.6893 6 11.0499 6.21142 11.2393 6.40877C11.4409 6.61877 11.5 6.86546 11.5 7C11.5 7.4539 11.2301 7.69835 10.7773 7.92363C10.6657 7.97916 10.552 8.02883 10.4343 8.0797L10.4116 8.08953C10.3056 8.13534 10.1902 8.18521 10.088 8.23655C9.98257 8.28953 9.85193 8.36283 9.7433 8.46505C9.62799 8.57355 9.5 8.75189 9.5 9V9.99999C9.5 10.2761 9.72386 10.5 10 10.5C10.2761 10.5 10.5 10.2753 10.5 9.99918V9.1493C10.5111 9.14333 10.5234 9.13694 10.537 9.13009C10.6125 9.09217 10.703 9.05302 10.8197 9.00257L10.8313 8.99753C10.948 8.94704 11.0843 8.8878 11.2227 8.81894C11.7699 8.5467 12.5 8.0461 12.5 7C12.5 6.63454 12.3591 6.13123 11.9607 5.71623C11.5501 5.28858 10.9107 5 10 5C9.08926 5 8.44985 5.28858 8.03931 5.71623C7.64091 6.13123 7.5 6.63454 7.5 7C7.5 7.27614 7.72386 7.5 8 7.5C8.27614 7.5 8.5 7.27614 8.5 7C8.5 6.86546 8.55909 6.61877 8.76069 6.40877ZM10 13C10.4142 13 10.75 12.6642 10.75 12.25C10.75 11.8358 10.4142 11.5 10 11.5C9.58579 11.5 9.25 11.8358 9.25 12.25C9.25 12.6642 9.58579 13 10 13Z" />
        </svg>
      </button>
    </div>

    <!-- Add Listing to VCC Help Dialog -->
    <div id="addListingToVccHelp" v-show="showAddListingHelp" class="modal">
      <div class="col ps-4 pe-4">
        <div class="row align-items-center justify-content-between mt-3 mb-4">
          <div class="row align-items-center">
            <svg class="me-2" style="fill: var(--neutral-foreground-rest)" width="20" height="20" viewBox="0 0 20 20" xmlns="http://www.w3.org/2000/svg">
              <path d="M4 4V16C4 17.1046 4.89543 18 6 18H15.5C15.7761 18 16 17.7761 16 17.5C16 17.2239 15.7761 17 15.5 17H6C5.44772 17 5 16.5523 5 16H15C15.5523 16 16 15.5523 16 15V4C16 2.89543 15.1046 2 14 2H6C4.89543 2 4 2.89543 4 4ZM14 3C14.5523 3 15 3.44772 15 4V15H5V4C5 3.44772 5.44772 3 6 3H14ZM8.76069 6.40877C8.95015 6.21142 9.31074 6 10 6C10.6893 6 11.0499 6.21142 11.2393 6.40877C11.4409 6.61877 11.5 6.86546 11.5 7C11.5 7.4539 11.2301 7.69835 10.7773 7.92363C10.6657 7.97916 10.552 8.02883 10.4343 8.0797L10.4116 8.08953C10.3056 8.13534 10.1902 8.18521 10.088 8.23655C9.98257 8.28953 9.85193 8.36283 9.7433 8.46505C9.62799 8.57355 9.5 8.75189 9.5 9V9.99999C9.5 10.2761 9.72386 10.5 10 10.5C10.2761 10.5 10.5 10.2753 10.5 9.99918V9.1493C10.5111 9.14333 10.5234 9.13694 10.537 9.13009C10.6125 9.09217 10.703 9.05302 10.8197 9.00257L10.8313 8.99753C10.948 8.94704 11.0843 8.8878 11.2227 8.81894C11.7699 8.5467 12.5 8.0461 12.5 7C12.5 6.63454 12.3591 6.13123 11.9607 5.71623C11.5501 5.28858 10.9107 5 10 5C9.08926 5 8.44985 5.28858 8.03931 5.71623C7.64091 6.13123 7.5 6.63454 7.5 7C7.5 7.27614 7.72386 7.5 8 7.5C8.27614 7.5 8.5 7.27614 8.5 7C8.5 6.86546 8.55909 6.61877 8.76069 6.40877ZM10 13C10.4142 13 10.75 12.6642 10.75 12.25C10.75 11.8358 10.4142 11.5 10 11.5C9.58579 11.5 9.25 11.8358 9.25 12.25C9.25 12.6642 9.58579 13 10 13Z" />
            </svg>
            <h3 class="m-0">How to add this listing to your VCC</h3> 
          </div>
          <button id="addListingToVccHelpClose" @click="showAddListingHelp = false">
            <svg width="20" height="20" viewBox="0 0 20 20" xmlns="http://www.w3.org/2000/svg">
              <path d="M4.08859 4.21569L4.14645 4.14645C4.32001 3.97288 4.58944 3.9536 4.78431 4.08859L4.85355 4.14645L10 9.293L15.1464 4.14645C15.32 3.97288 15.5894 3.9536 15.7843 4.08859L15.8536 4.14645C16.0271 4.32001 16.0464 4.58944 15.9114 4.78431L15.8536 4.85355L10.707 10L15.8536 15.1464C16.0271 15.32 16.0464 15.5894 15.9114 15.7843L15.8536 15.8536C15.68 16.0271 15.4106 16.0464 15.2157 15.9114L15.1464 15.8536L10 10.707L4.85355 15.8536C4.67999 16.0271 4.41056 16.0464 4.21569 15.9114L4.14645 15.8536C3.97288 15.68 3.9536 15.4106 4.08859 15.2157L4.14645 15.1464L9.293 10L4.14645 4.85355C3.97288 4.67999 3.9536 4.41056 4.08859 4.21569L4.14645 4.14645L4.08859 4.21569Z" />
            </svg>
          </button>
        </div>
        <p class="mb-1">
          To add this listing to your VCC (VRChat Creator Companion), do the following
        </p>
        <ul class="mt-1 ps-5">
          <li class="mb-2">Open your VCC and go to Settings</li>
          <li class="mb-2">Click the "Packages" tab</li>
          <li class="mb-2">Click "Add Repository"</li>
          <li class="mb-2">In the field that appears - paste the url displayed below</li>
          <li class="mb-2">Click "Add"</li>
          <li class="mb-2">Check the repository info and click "I Understand"</li>
          <li class="mb-2">Go to any of your projects to see the packages from the newly added listing.</li>
        </ul>
        <h5 class="m-0 mb-2">Listing URL</h5>
        <div class="row align-items-center">
          <input type="text" aria-readonly="true" id="vccListingInfoUrlField" class="vccUrlField" readonly :value="listingInfo.url">
          <button class="ms-2" id="vccListingInfoUrlFieldCopy" @click="copyToClipboard('vccListingInfoUrlField')">
            <svg slot="start" width="20" height="20" viewBox="0 0 20 20" xmlns="http://www.w3.org/2000/svg">
              <path d="M8 2C6.89543 2 6 2.89543 6 4V14C6 15.1046 6.89543 16 8 16H14C15.1046 16 16 15.1046 16 14V4C16 2.89543 15.1046 2 14 2H8ZM7 4C7 3.44772 7.44772 3 8 3H14C14.5523 3 15 3.44772 15 4V14C15 14.5523 14.5523 15 14 15H8C7.44772 15 7 14.5523 7 14V4ZM4 6.00001C4 5.25973 4.4022 4.61339 5 4.26758V14.5C5 15.8807 6.11929 17 7.5 17H13.7324C13.3866 17.5978 12.7403 18 12 18H7.5C5.567 18 4 16.433 4 14.5V6.00001Z"/>
            </svg>
            Copy
          </button>
        </div>
        <div class="caption1 mt-4">You can read more about Package Listings <a href="https://vcc.docs.vrchat.com" target="_blank">on the VCC docs</a></div>
      </div>
    </div>

    <!-- Search Block -->
    <div class="searchBlock">
      <input type="text" id="searchInput" placeholder="Search packages..." @input="filterPackages">
    </div>    <!-- Package List -->
    <div class="packages">
      <div id="packageGrid" role="grid" aria-label="Available packages">
        <div class="packageGrid-header row" role="row">
          <div class="grid-cell" role="columnheader" style="flex: 1">Name</div>
          <div class="grid-cell" role="columnheader" style="width: 100px">Type</div>
          <div class="grid-cell" role="columnheader" style="width: 220px">Actions</div>
        </div>
        <div v-for="(pkg, index) in filteredPackages" :key="index" class="packageGrid-row row" :data-package-name="pkg.displayName" :data-package-id="pkg.name" role="row">          <div class="grid-cell" role="gridcell" style="flex: 1">
            <div class="col">
              <div class="packageName">{{ pkg.displayName }}</div>
              <div class="caption1">{{ pkg.description }}</div>
              <div class="row" v-if="pkg.documentation">
                <a :href="pkg.documentation.url" target="_blank" class="doc-link mt-1">
                  <svg class="me-1" width="16" height="16" viewBox="0 0 20 20" xmlns="http://www.w3.org/2000/svg">
                    <path d="M6 2C4.89543 2 4 2.89543 4 4V16C4 17.1046 4.89543 18 6 18H14C15.1046 18 16 17.1046 16 16V7.41421C16 6.88378 15.7893 6.37507 15.4142 6L12 2.58579C11.6249 2.21071 11.1162 2 10.5858 2H6ZM5 4C5 3.44772 5.44772 3 6 3H10V5.5C10 6.32843 10.6716 7 11.5 7H14V16C14 16.5523 13.5523 17 13 17H7C6.44772 17 6 16.5523 6 16V4H6.5C6.77614 4 7 3.77614 7 3.5C7 3.22386 6.77614 3 6.5 3H6C5.44772 3 5 3.44772 5 4ZM11 3.70711L13.2929 6H11.5C11.2239 6 11 5.77614 11 5.5V3.70711Z" />
                  </svg>
                  {{ pkg.documentation.text || 'Documentation' }}
                </a>
              </div>
              <div class="caption2">{{ pkg.name }}</div>
            </div>
          </div>
          <div class="grid-cell row align-items-center" role="gridcell" style="width: 100px">
            {{ pkg.type }}
          </div>
          <div class="grid-cell row align-items-center justify-content-end" role="gridcell" style="width: 220px">
            <button class="rowAddToVccButton" :data-package-id="pkg.name" @click="addToVcc" aria-label="Add package to VCC">Add to VCC</button>
            <button class="rowPackageInfoButton ms-2" :data-package-id="pkg.name" @click="showPackageInfo(pkg)" aria-label="View package information">
              <svg width="20" height="20" viewBox="0 0 20 20" xmlns="http://www.w3.org/2000/svg" aria-hidden="true" focusable="false">
                <path d="M10.4921 8.91012C10.4497 8.67687 10.2456 8.49999 10.0001 8.49999C9.72397 8.49999 9.50011 8.72385 9.50011 8.99999V13.5021L9.50817 13.592C9.55051 13.8253 9.75465 14.0021 10.0001 14.0021C10.2763 14.0021 10.5001 13.7783 10.5001 13.5021V8.99999L10.4921 8.91012ZM10.7988 6.74999C10.7988 6.33578 10.463 5.99999 10.0488 5.99999C9.63461 5.99999 9.29883 6.33578 9.29883 6.74999C9.29883 7.16421 9.63461 7.49999 10.0488 7.49999C10.463 7.49999 10.7988 7.16421 10.7988 6.74999ZM18 10C18 5.58172 14.4183 2 10 2C5.58172 2 2 5.58172 2 10C2 14.4183 5.58172 18 10 18C14.4183 18 18 14.4183 18 10ZM3 10C3 6.13401 6.13401 3 10 3C13.866 3 17 6.13401 17 10C17 13.866 13.866 17 10 17C6.13401 17 3 13.866 3 10Z"/>
              </svg>
            </button>
          </div>
        </div>
      </div>
    </div>

    <!-- Package Info Modal -->
    <div id="packageInfoModal" v-show="showPackageInfoModal" class="modal">
      <div class="col ps-4 pe-4">
        <div class="row align-items-center justify-content-between mt-3 mb-4">
          <div class="col">
            <h3 class="m-0 mb-1" id="packageInfoName">{{ currentPackage.displayName }}</h3>
            <div class="row">
              <div class="caption1" id="packageInfoId">{{ currentPackage.name }}</div>
              <div class="caption1 ms-2" id="packageInfoVersion">v{{ currentPackage.version }}</div>
            </div>
          </div>
          <button id="packageInfoModalClose" @click="closePackageInfo">
            <svg width="20" height="20" viewBox="0 0 20 20" xmlns="http://www.w3.org/2000/svg">
              <path d="M4.08859 4.21569L4.14645 4.14645C4.32001 3.97288 4.58944 3.9536 4.78431 4.08859L4.85355 4.14645L10 9.293L15.1464 4.14645C15.32 3.97288 15.5894 3.9536 15.7843 4.08859L15.8536 4.14645C16.0271 4.32001 16.0464 4.58944 15.9114 4.78431L15.8536 4.85355L10.707 10L15.8536 15.1464C16.0271 15.32 16.0464 15.5894 15.9114 15.7843L15.8536 15.8536C15.68 16.0271 15.4106 16.0464 15.2157 15.9114L15.1464 15.8536L10 10.707L4.85355 15.8536C4.67999 16.0271 4.41056 16.0464 4.21569 15.9114L4.14645 15.8536C3.97288 15.68 3.9536 15.4106 4.08859 15.2157L4.14645 15.1464L9.293 10L4.14645 4.85355C3.97288 4.67999 3.9536 4.41056 4.08859 4.21569L4.14645 4.14645L4.08859 4.21569Z" />
            </svg>
          </button>
        </div>        <h5 class="m-0">Package Info</h5>
        <p class="mb-4 mt-1" id="packageInfoDescription">
          {{ currentPackage.description }}
        </p>
        <div v-if="currentPackage.documentation" class="mb-4">
          <a :href="currentPackage.documentation.url" target="_blank" class="documentation-link">
            <svg class="me-2" width="20" height="20" viewBox="0 0 20 20" xmlns="http://www.w3.org/2000/svg">
              <path d="M6 2C4.89543 2 4 2.89543 4 4V16C4 17.1046 4.89543 18 6 18H14C15.1046 18 16 17.1046 16 16V7.41421C16 6.88378 15.7893 6.37507 15.4142 6L12 2.58579C11.6249 2.21071 11.1162 2 10.5858 2H6ZM5 4C5 3.44772 5.44772 3 6 3H10V5.5C10 6.32843 10.6716 7 11.5 7H14V16C14 16.5523 13.5523 17 13 17H7C6.44772 17 6 16.5523 6 16V4H6.5C6.77614 4 7 3.77614 7 3.5C7 3.22386 6.77614 3 6.5 3H6C5.44772 3 5 3.44772 5 4ZM11 3.70711L13.2929 6H11.5C11.2239 6 11 5.77614 11 5.5V3.70711ZM8 9C8 8.44772 8.44772 8 9 8H12C12.5523 8 13 8.44772 13 9C13 9.55228 12.5523 10 12 10H9C8.44772 10 8 9.55228 8 9ZM8 13C8 12.4477 8.44772 12 9 12H12C12.5523 12 13 12.4477 13 13C13 13.5523 12.5523 14 12 14H9C8.44772 14 8 13.5523 8 13Z" />
            </svg>
            {{ currentPackage.documentation.text || 'Documentation' }}
          </a>
        </div>
        <h5 class="m-0">Author</h5>
        <p class="mb-4 mt-1">
          <a :href="currentPackage.author ? currentPackage.author.url : '#'" target="_blank" id="packageInfoAuthor">
            {{ currentPackage.author ? currentPackage.author.name : '' }}
          </a>
        </p>
        <h5 class="m-0 mb-2">Dependencies</h5>
        <ul class="mt-1 ps-5" id="packageInfoDependencies">
          <li v-for="(version, name) in currentPackage.dependencies" :key="name" class="mb-2">
            {{ name }} @ v{{ version }}
          </li>
        </ul>
        <div class="col" v-if="currentPackage.keywords && currentPackage.keywords.length > 0">
          <h5 class="m-0 mb-2">Keywords</h5>
          <div class="mb-2 mt-1 row" id="packageInfoKeywords">
            <div v-for="keyword in currentPackage.keywords" :key="keyword" class="me-2 mb-2 badge">
              {{ keyword }}
            </div>
          </div>
        </div>
        <div class="col" v-if="currentPackage.license || currentPackage.licensesUrl">
          <h5 class="m-0">License</h5>
          <a :href="currentPackage.licensesUrl || '#'" class="mb-4 mt-1" id="packageInfoLicense">
            {{ currentPackage.license || 'See License' }}
          </a>
        </div>
      </div>
    </div>
  </div>
</template>

<script>
// Import the source.json content
import sourceData from '@/assets/source.json';

export default {
  name: 'PeskyBoxListing',
  data() {
    return {
      listingInfo: {
        name: sourceData.name,
        id: sourceData.id,
        url: sourceData.url,
        author: sourceData.author,
        description: sourceData.description,
        infoLink: sourceData.infoLink
      },
      packages: [],
      filteredPackages: [],
      showAddListingHelp: false,
      showPackageInfoModal: false,
      currentPackage: {}
    };
  },
  mounted() {
    // Set up event listeners
    document.getElementById('urlBarHelp').addEventListener('click', () => {
      this.showAddListingHelp = true;
    });
    
    document.getElementById('vccUrlFieldCopy').addEventListener('click', () => {
      this.copyToClipboard('vccUrlField');
    });
    
    document.getElementById('vccAddRepoButton').addEventListener('click', () => {
      this.addToVcc();
    });

    // Generate sample packages from GitHub repos in source.json
    this.generatePackages();
  },
  methods: {
    generatePackages() {
      // Create sample packages from the GitHub repos in source.json
      if (sourceData.githubRepos && sourceData.githubRepos.length) {
        sourceData.githubRepos.forEach((repoPath, index) => {
          // Get metadata for this repo path if available
          const metadata = sourceData.packageMetadata ? sourceData.packageMetadata[repoPath] || {} : {};
          
          const parts = repoPath.split(':');
          const repoFullName = parts.length > 1 ? parts[1] : repoPath;
          const [owner, repo] = repoFullName.split('/');
          
          this.packages.push({
            name: `com.${owner.toLowerCase()}.${repo.toLowerCase().replace(/-/g, '.')}`,
            displayName: repo.replace(/-/g, ' '),
            description: metadata.customDescription || `A package from ${owner}/${repo}`,
            version: '1.0.' + index,
            type: 'Tool',
            author: {
              name: owner,
              url: `https://github.com/${owner}`
            },
            dependencies: {
              'com.vrchat.base': '3.1.0'
            },
            keywords: ['vrchat', 'tool'],
            license: 'MIT',
            licensesUrl: `https://github.com/${owner}/${repo}/blob/main/LICENSE`,
            documentation: metadata.documentation || null
          });
        });
      }
      
      // Add any additional packages from source.json
      if (sourceData.packages && sourceData.packages.length) {
        sourceData.packages.forEach((pkg) => {
          this.packages.push(pkg);
        });
      }
      
      this.filteredPackages = [...this.packages];
    },
    filterPackages(e) {
      const searchTerm = e.target.value.toLowerCase();
      if (!searchTerm) {
        this.filteredPackages = [...this.packages];
        return;
      }
      
      this.filteredPackages = this.packages.filter(pkg => 
        pkg.name.toLowerCase().includes(searchTerm) || 
        pkg.displayName.toLowerCase().includes(searchTerm) ||
        pkg.description.toLowerCase().includes(searchTerm)
      );
    },
    copyToClipboard(elementId) {
      const element = document.getElementById(elementId);
      if (element) {
        element.select();
        document.execCommand('copy');
      }
    },
    addToVcc() {
      // In a real application, this would use the VCC protocol to add the repository
      window.location.assign(`vcc://vpm/addRepo?url=${encodeURIComponent(this.listingInfo.url)}`);
    },
    showPackageInfo(pkg) {
      this.currentPackage = pkg;
      this.showPackageInfoModal = true;
    },
    closePackageInfo() {
      this.showPackageInfoModal = false;
    }
  }
};
</script>

<style scoped>
.content {
  width: 100%;
  max-width: 1200px; /* Increase the max-width to make the content wider */
  margin: 0 auto;
}

.content {
  max-width: 1500px;
  width: 100%;
  margin: 0 auto;
  padding: 2rem 1rem;
  position: relative;
}

.content::before {
  content: '';
  position: absolute;
  top: 0;
  left: 5%;
  width: 90%;
  height: 100%;
  background: linear-gradient(180deg, 
    rgba(173, 216, 230, 0.1) 0%, 
    rgba(230, 230, 250, 0.05) 100%);
  filter: blur(60px);
  z-index: -1;
  pointer-events: none;
}

.caption1 {
  font-size: 1rem;
  color: var(--primary-lavender);
}

.caption2 {
  font-size: 0.8rem;
  margin-top: 0.25rem;
  color: var(--primary-lavender);
  opacity: 0.7;
}

/* Header styling */
#listingInfo {
  position: relative;
  border-radius: 12px;
  padding: 2rem;
  background: linear-gradient(135deg, rgba(26, 26, 26, 0.9) 0%, rgba(15, 0, 20, 0.8) 100%);
  box-shadow: 0 8px 32px rgba(0, 0, 0, 0.3);
  backdrop-filter: blur(4px);
  border: 1px solid rgba(106, 13, 173, 0.2);
  position: relative;
  overflow: hidden;
}

#listingInfo::before {
  content: '';
  position: absolute;
  top: 0;
  left: 0;
  right: 0;
  bottom: 0;
  background-image: url("data:image/svg+xml,%3Csvg viewBox='0 0 220 220' xmlns='http://www.w3.org/2000/svg'%3E%3Cdefs%3E%3Cpattern id='halftone' x='0' y='0' width='20' height='20' patternUnits='userSpaceOnUse'%3E%3Ccircle cx='10' cy='10' r='1' fill='%23BDB0D0' opacity='0.15'/%3E%3C/pattern%3E%3C/defs%3E%3Crect width='100%25' height='100%25' fill='url(%23halftone)'/%3E%3C/svg%3E");
  opacity: 0.5;
  z-index: 0;
}

#listingInfo > * {
  position: relative;
  z-index: 1;
}

h1 {
  margin-top: 0.5rem;
  margin-bottom: 1rem;
  font-size: 2.5rem;
  background: linear-gradient(90deg, 
    var(--primary-lavender) 0%, 
    var(--primary-light-lavender) 50%,
    var(--secondary-cyan) 100%);
  background-clip: text;
  -webkit-background-clip: text;
  -webkit-text-fill-color: transparent;
  filter: drop-shadow(0 2px 2px rgba(106, 13, 173, 0.5));
}

#publishedByText a {
  font-weight: 500;
}

/* Packages section styling */
.packages {
  margin: 1.5rem 0;
  max-width: 90%;
  padding: 0.5rem;
  display: flex;
  flex: 1;
  background: rgba(26, 26, 26, 0.7);
  border-radius: 12px;
  box-shadow: 0 8px 32px rgba(0, 0, 0, 0.2);
  backdrop-filter: blur(4px);
  border: 1px solid rgba(106, 13, 173, 0.3);
  position: relative;
  overflow: hidden;
}

.packages::before {
  content: '';
  position: absolute;
  top: 0;
  left: 0;
  width: 100%;
  height: 100%;
  background-image: url("data:image/svg+xml,%3Csvg viewBox='0 0 220 220' xmlns='http://www.w3.org/2000/svg'%3E%3Cdefs%3E%3Cpattern id='halftone' x='0' y='0' width='20' height='20' patternUnits='userSpaceOnUse'%3E%3Ccircle cx='10' cy='10' r='1' fill='%23BDB0D0' opacity='0.1'/%3E%3C/pattern%3E%3C/defs%3E%3Crect width='100%25' height='100%25' fill='url(%23halftone)'/%3E%3C/svg%3E");
  z-index: -1;
  opacity: 0.3;
}

#packageGrid {
  overflow-y: auto;
  width: 100%;
  max-height: 40rem;
  position: relative;
  z-index: 1;
}

#packageGrid::-webkit-scrollbar {
  width: 8px;
}

#packageGrid::-webkit-scrollbar-track {
  background: rgba(26, 26, 26, 0.5);
  border-radius: 4px;
}

#packageGrid::-webkit-scrollbar-thumb {
  background: linear-gradient(180deg, 
    var(--primary-purple) 0%, 
    var(--secondary-magenta) 100%);
  border-radius: 4px;
}

.packageGrid-header {
  border-bottom: 1px solid var(--primary-purple);
  padding: 12px;
  font-weight: bold;
  letter-spacing: 0.05em;
  color: var(--primary-light-lavender);
  background: rgba(15, 0, 20, 0.4);
}

.packageGrid-row {
  border-bottom: 1px solid rgba(106, 13, 173, 0.3);
  padding: 12px;
  transition: all 0.3s ease;
}

.packageGrid-row:hover {
  background: linear-gradient(90deg, 
    rgba(106, 13, 173, 0.3) 0%, /* Slightly increase opacity or change color */
    rgba(26, 26, 26, 0.6) 100%);
  /* Removed transform: translateX(5px); */
}

.packages .packageName {
  font-size: 1.1rem;
  font-weight: 600;
  margin: 0.25rem 0;
  color: var(--primary-light-lavender);
  text-shadow: 0 0 10px rgba(173, 216, 230, 0.3);
}

/* Search input styling */
.searchBlock {
  margin-top: 1.5rem;
  width: 100%;
  max-width: 90%;
  position: relative;
}

#searchInput {
  width: 100%;
  padding: 12px 15px;
  border: 1px solid var(--primary-purple);
  border-radius: 8px;
  background: rgba(26, 26, 26, 0.7);
  color: var(--primary-light-lavender);
  font-size: 1rem;
  transition: all 0.3s ease;
  box-shadow: 0 4px 12px rgba(0, 0, 0, 0.2);
  backdrop-filter: blur(4px);
}

#searchInput:focus {
  outline: none;
  border-color: var(--secondary-magenta);
  box-shadow: 0 0 0 3px rgba(255, 0, 255, 0.2), 0 4px 12px rgba(0, 0, 0, 0.3);
}

#searchInput::placeholder {
  color: var(--primary-lavender);
  opacity: 0.7;
}

/* URL Field styling */
.vccUrlField {
  min-width: 450px;
  max-width: 90%;
  flex-grow: 1;
  padding: 12px 15px;
  border: 1px solid var(--primary-purple);
  border-radius: 8px;
  background: rgba(26, 26, 26, 0.7);
  color: var(--primary-light-lavender);
  font-size: 1rem;
  box-shadow: 0 4px 12px rgba(0, 0, 0, 0.2);
  backdrop-filter: blur(4px);
}

/* Add to VCC Block styling */
.addToVccBlock {
  background: linear-gradient(135deg, 
    rgba(26, 26, 26, 0.8) 0%, 
    rgba(15, 0, 20, 0.7) 100%);
  padding: 1.5rem;
  border-radius: 12px;
  width: 100%;
  max-width: 90%;
  box-shadow: 0 8px 32px rgba(0, 0, 0, 0.2);
  backdrop-filter: blur(4px);
  border: 1px solid rgba(106, 13, 173, 0.3);
}

/* Modal styling */
.modal {
  position: fixed;
  z-index: 100;
  left: 0;
  top: 0;
  width: 100%;
  height: 100%;
  background: radial-gradient(circle at center, 
    rgba(15, 0, 20, 0.9) 0%, 
    rgba(0, 0, 0, 0.95) 100%);
  display: flex;
  align-items: center;
  justify-content: center;
  backdrop-filter: blur(10px);
}

.modal > div {
  background: linear-gradient(135deg, 
    rgba(26, 26, 26, 0.9) 0%, 
    rgba(15, 0, 20, 0.95) 100%);
  border-radius: 12px;
  max-width: 600px;
  width: 90%;
  max-height: 90vh;
  overflow-y: auto;
  padding: 25px;
  box-shadow: 0 15px 50px rgba(0, 0, 0, 0.5);
  border: 1px solid rgba(106, 13, 173, 0.3);
  position: relative;
}

.modal > div::before {
  content: '';
  position: absolute;
  top: 0;
  left: 0;
  width: 100%;
  height: 100%;
  background-image: url("data:image/svg+xml,%3Csvg viewBox='0 0 220 220' xmlns='http://www.w3.org/2000/svg'%3E%3Cdefs%3E%3Cpattern id='halftone' x='0' y='0' width='20' height='20' patternUnits='userSpaceOnUse'%3E%3Ccircle cx='10' cy='10' r='1' fill='%23BDB0D0' opacity='0.1'/%3E%3C/pattern%3E%3C/defs%3E%3Crect width='100%25' height='100%25' fill='url(%23halftone)'/%3E%3C/svg%3E");
  z-index: -1;
  opacity: 0.4;
  pointer-events: none;
}

/* Button styling */
button {
  background: linear-gradient(135deg, var(--primary-purple) 0%, var(--secondary-magenta) 100%);
  color: white;
  border: none;
  padding: 10px 18px;
  border-radius: 8px;
  cursor: pointer;
  display: flex;
  align-items: center;
  font-weight: 500;
  position: relative;
  overflow: hidden;
  transition: all 0.3s ease;
  box-shadow: 0 4px 12px rgba(106, 13, 173, 0.3);
  text-shadow: 0 1px 2px rgba(0, 0, 0, 0.3);
}

button::before {
  content: '';
  position: absolute;
  top: 0;
  left: -100%;
  width: 100%;
  height: 100%;
  background: linear-gradient(90deg, 
    rgba(255, 255, 255, 0) 0%, 
    rgba(255, 255, 255, 0.2) 50%, 
    rgba(255, 255, 255, 0) 100%);
  transition: all 0.6s ease;
}

button:hover {
  background: linear-gradient(135deg, var(--secondary-magenta) 0%, var(--primary-purple) 100%);
  transform: translateY(-2px);
  box-shadow: 0 6px 16px rgba(106, 13, 173, 0.4);
}

button:hover::before {
  left: 100%;
}

button:active {
  transform: translateY(1px);
  box-shadow: 0 2px 6px rgba(106, 13, 173, 0.3);
}

button svg {
  fill: white;
}

/* Additional element styles */
.badge {
  border-radius: 6px;
  padding: 0.25rem 0.75rem;
  background: linear-gradient(135deg, 
    var(--primary-purple) 0%, 
    var(--secondary-magenta) 100%);
  color: white;
  font-size: 0.8rem;
  font-weight: 500;
  box-shadow: 0 2px 6px rgba(106, 13, 173, 0.3);
  text-shadow: 0 1px 2px rgba(0, 0, 0, 0.3);
  border: 1px solid rgba(255, 255, 255, 0.1);
}

.grid-cell {
  padding: 8px;
}

/* Styled scrollbars */
::-webkit-scrollbar {
  width: 8px;
}

::-webkit-scrollbar-track {
  background: rgba(26, 26, 26, 0.5);
  border-radius: 4px;
}

::-webkit-scrollbar-thumb {
  background: linear-gradient(180deg, 
    var(--primary-purple) 0%, 
    var(--secondary-magenta) 100%);
  border-radius: 4px;
}

/* Row buttons */
.rowAddToVccButton, .rowPackageInfoButton {
  font-size: 0.9rem;
}

.rowPackageInfoButton {
  background: linear-gradient(135deg, rgba(26, 26, 26, 0.5) 0%, rgba(51, 51, 51, 0.5) 100%);
  border: 1px solid rgba(106, 13, 173, 0.3);
}

.rowPackageInfoButton:hover {
  background: linear-gradient(135deg, rgba(51, 51, 51, 0.6) 0%, rgba(26, 26, 26, 0.6) 100%);
}

/* Documentation link styling */
.doc-link {
  display: flex;
  align-items: center;
  font-size: 0.85rem;
  padding: 3px 10px;
  background: rgba(106, 13, 173, 0.2);
  border-radius: 4px;
  color: var(--secondary-cyan);
  width: fit-content;
  transition: all 0.3s ease;
}

.doc-link:hover {
  background: rgba(106, 13, 173, 0.4);
  transform: translateY(-1px);
  box-shadow: 0 2px 8px rgba(173, 216, 230, 0.3);
}

.doc-link svg {
  fill: var(--secondary-cyan);
}

.documentation-link {
  display: flex;
  align-items: center;
  font-size: 1rem;
  padding: 6px 14px;
  background: rgba(106, 13, 173, 0.2);
  border-radius: 6px;
  color: var(--secondary-cyan);
  width: fit-content;
  transition: all 0.3s ease;
}

.documentation-link:hover {
  background: rgba(106, 13, 173, 0.4);
  transform: translateY(-1px);
  box-shadow: 0 2px 8px rgba(173, 216, 230, 0.3);
}

.documentation-link svg {
  fill: var(--secondary-cyan);
}
</style>
